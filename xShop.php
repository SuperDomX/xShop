<?php
/**
 * @name Shop
 * @desc Online Web Shop
 * @version v1(2.6)
 * @author i@xtiv.net
 * @price $100
 * @icon shop-icon.png
 * @mini shopping-cart
 * @see market
 * @link shop
 * @delta true
 * @release delta
 */

	class xShop extends Xengine{
		var $importDir = '/upload/';
		var $shelvesDir = '/shelves/';
		
		function dbSync(){
			return array(
				'shop_inventory_item'	 => array(
					'name'			=>	array('Type' => 'varchar(255)'),
					'sku'			=>	array('Type' => 'varchar(100)'),
					'viewed'		=>	array('Type' => 'int(8)'),
					'held'			=>	array('Type' => 'int(8)'), 
					'sold'			=>	array('Type' => 'int(8)'),
					'returned'		=>	array('Type' => 'int(8)'),
					'price'			=>	array('Type' => 'varchar(255)'),
					'stock'			=>	array('Type' => 'int(8)','Default'=>0),
					'tags'			=>	array('Type' => 'blob'),
					'rating'		=>  array('Type' => 'int(12)'),
					'votes'			=>  array('Type' => 'int(8)'),
					'first_added'	=> array('Type'=>'TIMESTAMP','Default'=>'CURRENT_TIMESTAMP'),
					'last_updated'	=> array('Type'=>'TIMESTAMP','Default'=>'CURRENT_TIMESTAMP'),
					'last_sold'		=> array('Type' => 'datetime'),
					'first_sold'	=> array('Type' => 'datetime')
				),
				'shop_inventory_pics' => array(
					'src'			=>	array('Type' => 'varchar(255)'),
					'item_id'		=>	array('Type' => 'varchar(255)'),
					'dimension'		=>	array('Type' => 'varchar(2)'),
				),
				'shop_inventory_attributes' => array(
					'item_id'		=>	array('Type' => 'int(8)'),
					'option'		=>	array('Type' => 'varchar(255)'),	
					'value'			=>	array('Type' => 'varchar(255)'), 
				), 
				// 'shop_orders'	=> array(
					 
				// ),
				// 'shop_settings'	=> array(
				// 	'config_value'		=>	array('Type' => 'blob'),
				// 	'config_option'		=>	array('Type' => 'varchar(255)')
				// ),
				// 'shop_customers' =>array( 

					
				// )
			);
		}
		
		function autoRun($x){
			// $x->q()->UPDATE('shop_inventory_item',array('stock'=>0),"stock is null");

			return array(
				'shop' => array(
					'dir' => array(
						'imports' => $this->importDir,
						'shelves' => $this->shelvesDir
					)
				)
			);
		}

		/**
			@name catalog
			@blox Shop Catalog
			@desc Simple Easy to use Custom Code Blox
			@icon book
		**/
		public function catalog()
		{
			# code...
		}

		function index(){
			$f = array('label','price','stock','sold','id');
			$this->set('inventory_attr',	json_encode($f)	);
			
		}
 
		function upload($uploading){
			if($uploading==true){ 
				$c = $this->_CFG;

				$cfg = explode('/', $c['dir']['cfg']);
				$cfg = $cfg[count($cfg)-1];

 				$o = array(
					'script_url' => $_SERVER['REQUEST_URI'].'/',
					'upload_dir' => $this->importDir, 
					'upload_url' => ''
						.'/'.$c['dir']['backdoor']
						.'/'.$cfg
						.'/'.HTTP_HOST
						.'/'.$this->_SET['action']
						.$this->importDir,
					// 'upload_dir' => DOC_ROOT.'/_cfg/'.$_SERVER['HTTP_HOST'].'/xShop/',
	        		// 'upload_url' => $_SERVER['HTTP_HOST'].'/files/',
	        		// 'user_dirs'  => true
	        	);
	        	$this->jqUpload($o);
			}
		}		



		/**
			@name import
			@blox Import
			@desc Import Inventory
			@backdoor true
			@filter catalog
			@icon cloud-upload
		**/
		function import()
		{
			if($_POST['shelf']){
				return $this->addToShelf($_POST);
			}else{
				return array('data' => $this->scanImgs() );
			}
		}
 

		private function addtoShelf($p){
			// Find the images that match the sku.
			$files = $this->scanImgs();
			$files = $files['files'];

			// Find Only the Files that match the sku
			foreach ($files as $key => $value) {
				if(!strstr($value, $p['shelf']['sku'])){
					unset($files[$key]);
				}
			}

			$dir = $this->_SET['upload_dir'].$this->shelvesDir;

			if( !is_dir($dir) ){
				mkdir($dir);
			}

			$dir = $dir.$p['shelf']['sku'];
			if( !is_dir($dir) ){
				mkdir($dir);
				$count = 1;
			}else{
				$count = scandir($dir);
				$count = count($count);
			}

			// Attempt to add to the Database  
			$q = $this->q();
			$get = $q->Select('id','shop_inventory_item', array(
				'sku' => $p['shelf']['sku']
			));

			if(empty($get)){ 
				$add = $q->Insert('shop_inventory_item',$p['shelf']);
			}else{
				$add = $q->Update('shop_inventory_item',$p['shelf'],array(
					'sku' =>  $p['shelf']['sku']
				));
			}


			if($add ){
				// Move / Rename the images.
				$i=$count;
				$new_file = implode(',', $p['shelf']);

				foreach ($files as $key => $value){
					$file = $this->_SET['upload_dir'].$this->importDir.$value;
					$ext = explode('.', $value);
					$ext = $ext[count($ext)-1];
					rename($file, $dir."/($i).$ext");				
					$i++;
				}
			}

			// Count how many images 
			return array(
				'success' => $add,
				'data'    => $_POST,
				'files'   => $files,
				'dir'     => $dir,
				'error'   => $q->error
			);
		}

		private function updateShelf($p){
			// Attempt to add to the Database  
			$q = $this->q();
			$item = $q->Select('sku','shop_inventory_item', array(
				'id' => $p['shelf']['id']
			));
			$item = $item[0];

			$dir = $this->_SET['upload_dir'].$this->shelvesDir;
			
			// mv the Pictures
			if( $item['sku'] != $p['shelf']['sku'] ){ 
				$old = $dir.$item['sku'].'/';
				$new = $dir.$p['shelf']['sku'].'/';

				rename($old,$new);  
				$f = scandir($new);
				$i=1;
				foreach ($f as $key => $value) { 
					if(is_file($new.$value)){
						$ext = explode('.', $value);
						$ext = strtolower($ext[count($ext)-1]); 
						rename($new.$value, $new."($i).$ext" );
						$i++;
					}
					
				}  
			}

			$id = $q->Update('shop_inventory_item',$p['shelf'],array(
				'id' => $p['shelf']['id']
			));
 
			// Count how many images 
			return array(
				'success' => $id,
				'data'    => array(
					'post'  => $_POST,
					'files' => $f,
					'item' => $item
				), 
				'error'   => $q->error
			);
		}
 
		private function scanImgs()
		{
			function parseFileName($item,$i,$value){ 
				$cost 	=  $item[count($item)-1];
				unset($item[count($item)-1]);

				$sku 	=  $item[count($item)-1];
				unset($item[count($item)-1]);

				$name = implode(' ', $item);

				$filename = [$name,$sku,$cost];

				//echo rename ( $dir.$value , $dir.'../'.$filename.'.jpg');
				$hash = str_replace(' ', '-', $name);
				$type[$hash] = $name;
				return array(
					'name' => $name, 
					'sku'  => $sku,
					'cost' => $cost, 
					'pic'  => $value,
					'hash' => $hash
				);
			}

			$d = $this->_SET['upload_dir'].$this->importDir;

			$files = scandir($d,0); 

			$start = ($_GET['start']) ? $_GET['start'] : 0;
			$limit = ($_GET['limit']) ? $_GET['limit'] : 10;

			foreach ($files as $key => $value) {	// Amethyst Light R85 $133 (2).JPG 
				
				if($value != '.' && $value != '..'){
					$item = explode('.', $value); 		// [Amethyst Light R85 $133 (2)] [JPG] 
					$item = $name = $item[0]; 			  		// Amethyst Light R85 $133 (2) 
					$item = explode(' ', $item);		// [Amethyst] [Light] [R85] [$133] [(2)] 
					
					if($item[count($item)-1] == '' || strstr($item[count($item)-2], '$') ){
						unset($item[count($item)-1]);
					}

					if(strstr($item[count($item)-1], '$')  ){ 
						$item = parseFileName($item,1,$value);
						$shelf[$item['sku']] = $item; 
					} elseif($name  != 'thumbnail') {
						//$item = parseFileName($item,2);
						$shelf[$value] = array(
							'name' => 'Item', 
							'sku'  => str_replace("IMG_", "", $name),
							'cost' => '$0', 
							'pic'  => $value,
							'hash' => md5($item)
						);;
					}
				}
			}

			$shelf = array_slice($shelf,$start,$limit);	

			foreach ($shelf as $key => $value) {
				//echo rename ( $dir.$value , $dir.'../'.$filename.'.jpg');
				$type[$value['hash']] = $value['name'];
				# code...
			}
 
			# code...
			return array(
				'shelf' => $shelf,
				'files'	=> $files
			);
		}

		private function scanRandomImgs()
		{ 
			$dir    =  $this->_SET['upload_dir'].$this->importDir;
			$files = scandir($dir,0); 

			$start = ($_GET['start']) ? $_GET['start'] : 0;
			$limit = ($_GET['limit']) ? $_GET['limit'] : 10;

			foreach ($files as $key => $value) {	// Amethyst Light R85 $133 (2).JPG 
				
				if($value != '.' && $value != '..'){
					$item = explode('.', $value); 		// [Amethyst Light R85 $133 (2)] [JPG] 
					$item = $name = $item[0]; 			  		// Amethyst Light R85 $133 (2) 
					$item = explode(' ', $item);		// [Amethyst] [Light] [R85] [$133] [(2)] 
					
					if($item[count($item)-1] == ''){
						unset($item[count($item)-1]);
					}

					$shelf[] = array(
						'name' => $name, 
						'sku'  => $value,
						'cost' => '', 
						'pic'  => $value,
						'hash' => md5($item)
					);
					 
				}


			}

			# code...
			return array(
				'shelf' => $shelf 
			);
		}

		function jumbotron(){
			// Pull the Jumbotron from somewhere online... That way we can keep the DOCs updated for all...?			
		}

		function topX(){
			$dir    = $this->_SET['upload_dir'].$this->importDir;
			$files  = scandir($dir,0); 

			$blacklist = array('.','..','thumbnail');
			foreach ($files as $key => $value) {
				foreach ($blacklist as $v) {
					if($v == $value){
						unset($files[$key]);
					}
				}
			}

			$this->set('topX',array(
				'import' => count($files)
			)); 
		}

		function wizardItem(){
			
		}

		function shelves()
		{
			# code...
		}

		function brick(){
			
		}

		function readImgDir(){

			
			if ($handle = opendir('./img/shop')) {
			    echo "Directory handle: $handle\n";
			    echo "Entries:\n";

			    /* This is the correct way to loop over the directory. */
			    while (false !== ($entry = readdir($handle))) {

			    	$item = explode(' ', $entry);

			        ?>

				        <div class="product large">
							<div class="media">
							<?php echo $entry;?>
								<a href="product.html" title="product title">
									<img src='img/shop/<?php echo $entry;?>' alt="product title" data-img="product-1" class="img-responsive" />
								</a>
								<span class="plabel">just in</span>				
							</div>
							<div class="details">
								<p class="name">
									<a href="product.html">
										<?php echo $item[0];	?>
									</a>
								</p>
								<p class="price"><!-- <span class="cur">$</span> --><span class="total"><?php echo $item[2];	?></span></p>
								<a href="" class="details-expand" data-target="details-0001">+</a>
							</div>
							<div class="details-extra" id="details-0001">
								<form class="form-inline" action="#">
									<div>
										<label>Quantity</label>	
										<input type="text" class="input-sm form-control quantity" value="1">
									</div>
									<div>
										<label>Size</label>
										<select class="input-sm form-control size">
											<option>S</option>
											<option>M</option>
											<option>L</option>										
										</select>
									</div>
								</form>
								<button class="btn btn-bottom btn-atc qadd">Add to cart</button>			
							</div>
						</div>

			        <?php 
			    }
	 

			    closedir($handle);
			}

			
		}


		/**
			@name inventory
			@blox Inventory
			@desc Manage Inventory
			@backdoor true
			@filter items
			@icon book
		**/
		function inventory($select='*'){
			if(isset($_POST['shelf'])){
				return $this->updateShelf($_POST);
			}

			$q = $this->q();

			$l = ( isset($_GET['limit']) ) ? $_GET['limit'] : array(0,10);
			
			$q->setStartLimit( $l[0], $l[1] );




			$i = $q->Select($select,'shop_inventory_item',"stock > -1 OR stock is null ");

			foreach ($i as $key => $value) { 
				$dir = $this->_SET['upload_dir'].$this->shelvesDir.$value['sku'].'/';
				
				if(!is_dir($dir)){
					// Items are organized in the databased based on their SKUs
					// If an item isnt found on the shelf. it's taken out of the database to avoid errors...
					$q->Delete('shop_inventory_item',array(
						'id' => $value['id']
					));
					unset($i[$key]);
				}else{ 
					$pics[$value['sku']] = scandir($dir);
					
					$blacklist = array('.','..');
					foreach ($pics[$value['sku']] as $k => $v) {
						foreach ($blacklist as $b) {
							if($b == $v){
								unset($pics[$value['sku']][$k]);
							}
						}
					}
					
					$pics[$value['sku']] = array_values($pics[$value['sku']]);
				}
			}

			return array(
				'data' => array(
					'pics'      => $pics,
					'inventory' => $i,
					'tags'		=> $this->getTags()
				),
				'start' => $l[0]+$l[1],
				'limit' => $l[1],
			);
		}

		function bazaar($html=false)
		{



			$bazaar = $this->inventory();
			$bazaar['raw'] = $html;

			$bazaar['basket_count'] = (isset($_SESSION['cart'])) ? count($_SESSION['cart']) : 0;


			return $bazaar;
		}

		private function getItemPics($items)
		{
			foreach ($items as $key => $value) { 
				$dir = $this->_SET['upload_dir'].$this->shelvesDir.$value['sku'].'/';
				
				if(!is_dir($dir)){
					// Items are organized in the databased based on their SKUs
					// If an item isnt found on the shelf. it's taken out of the database to avoid errors...
					$q->Delete('shop_inventory_item',array(
						'id' => $value['id']
					));
					unset($i[$key]);
				}else{ 
					$pics[$value['sku']] = scandir($dir);
					
					$blacklist = array('.','..');
					foreach ($pics[$value['sku']] as $k => $v) {
						foreach ($blacklist as $b) {
							if($b == $v){
								unset($pics[$value['sku']][$k]);
							}
						}
					}
					
					$pics[$value['sku']] = array_values($pics[$value['sku']]);
				}
			}
			return $pics;
		}

		function listItems()
		{
			$data = $this->inventory('id,name,price,sku,tags,stock,viewed'); 
			$data = $data['data']; 

			foreach ($data['inventory'] as $key => $value) {
				# code...
				$array = array();
				foreach ($value as $k => $v) {
					$array[] = $v;	
				}
				$data['inventory'][$key] = $array;
			}

			return array(
				'draw' 			=> 1,
				'recordsFiltered' => count($data['inventory']),
				'recordsTotal' =>  count($data['inventory']),
				'data'         => $data['inventory']
			);
		}

		function item($sku){
			$q = $this->q();
			$sku = array( 'sku' => $sku);

			$product = $q->Select('*','shop_inventory_item',$sku);	
			return array(
				'data' => array(
					'pics'	=> $this->getItemPics($product),
					'product'=> $product
				)
			);
		}

		public function cart($s,$sku)
		{
			switch ($s) {
				case 'add':
					$_SESSION['cart'][$sku] = $sku;
				break;

				case 'remove': 

				foreach ($_SESSION['cart'] as $key => $value) {
					if($value == $sku)
						unset($_SESSION['cart'][$key]);
				}

					unset($_SESSION['cart'][$sku]);
				break;
				
				default:
					# code...	
				break;
			}
		}

		public function checkout($action=null,$sku=null)
		{


			$q = $this->q();

			if($action == 'remove'){
				$this->cart('remove',$sku);
			}elseif( $action == 'pay' ){

				$this->lib('stripe/Stripe.php');
				// Set your secret key: remember to change this to your live secret key in production
				// See your keys here https://dashboard.stripe.com/account

				$key = $q->Select('*','config',array(
					'config_option' => 'stripe_key'
				)); 

				$key = $key[0]['config_value'];
				
				Stripe::setApiKey($key);

				// Get the credit card details submitted by the form
				$token = $_POST['id'];
				$amount = $_POST['amount'];
 

				
				$cus = $q->Select('stripe_id','Users',array(
					'id' => $_SESSION['user']['id']
				));

				if( !empty($cus) && $cus[0]['stripe_id'] != '' ){
					$cus_id = $cus[0]['stripe_id']; 

				}else{
					// Create a Customer
					$customer = Stripe_Customer::create(array(
					  "card" 		=> $token,
					  "description" => $_POST['email']
					));

					$cus_id = $customer->id;

					$q->Update('Users',array(
						'stripe_id' => $cus_id
					),array(
						'id' => $_SESSION['user']['id']
					));
				}


				 

				try {
					$charge = Stripe_Charge::create(array(
						"amount"   => 100 * $amount, # amount in cents, again
						"currency" => "usd",
						"customer" => $cus_id
					));
				} catch(Stripe_CardError $e) {
				  // Since it's a decline, Stripe_CardError will be caught
				  $body = $e->getJsonBody();
				  $err  = $body['error'];

				  print('Status is:' . $e->getHttpStatus() . "\n");
				  print('Type is:' . $err['type'] . "\n");
				  print('Code is:' . $err['code'] . "\n");
				  // param is '' in this case
				  print('Param is:' . $err['param'] . "\n");
				  print('Message is:' . $err['message'] . "\n");
				  $checkout['error'] =  $err['message'];
				} catch (Stripe_InvalidRequestError $err ) {
				  // Invalid parameters were supplied to Stripe's API
					$checkout['error'] = $err->getMessage();
				} catch (Stripe_AuthenticationError $err) {
				  // Authentication with Stripe's API failed
				  // (maybe you changed API keys recently)
					$checkout['error'] = $err->getMessage();
				} catch (Stripe_ApiConnectionError $err) {
				  // Network communication with Stripe failed
					$checkout['error'] = $err->getMessage();
				} catch (Stripe_Error $err) { 
				  // Display a very generic error to the user, and maybe send
				  // yourself an email
					$checkout['error'] = $err->getMessage();
				} catch (Exception $err) {
				  // Something else happened, completely unrelated to Stripe
					$checkout['error'] = $err->getMessage();
				}

				$checkout['success'] = true;

				return $checkout;
				// Save the customer ID in your database so you can use it later
				// saveStripeCustomerId($user, $customer->id);

				// // Later...
				// $customerId = getStripeCustomerId($user);

				// Stripe_Charge::create(array(
				//   "amount"   => 1500, # $15.00 this time
				//   "currency" => "usd",
				//   "customer" => $customerId)
				// );

			}

			$total = 0;
			foreach ($_SESSION['cart'] as $key => $sku) {
				$i = $q->Select('*','shop_inventory_item',array(
					'sku' => $sku
				));

				$price = intval(substr($i[0]['price'], 1));

				$total = $price + $total;

				$items[] = $i[0];
			}

			$checkout['data']['total'] = $total;
			$checkout['data']['items'] = $items;
			$checkout['data']['pics'] = $this->getItemPics( $items);

			return $checkout;

		}

		public function getTags()
		{
			$q = $this->q();

			$items = $q->Select('tags','shop_inventory_item');

			foreach ($items as $r => $c) {
				$tag = explode(",", $c['tags']);

				foreach ($tag as $k => $v) {
					$tags[$v] = $v;
				} 
			}

			asort($tags);

			return $tags;
		}

		public function thanks()
		{
			$q = $this->q();
			foreach ($_SESSION['cart'] as $k => $sku) { 
				$q->Inc('shop_inventory_item','stock',-1, array('sku'=>$sku) );
				# code...
			}


			unset($_SESSION['cart']);
		}
	}
?>