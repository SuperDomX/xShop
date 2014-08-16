<?php
/**
 * @name Shop
 * @desc Online Web Shop
 * @version v1(4.0)-RC1
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
				// 'shop_inventory_pics' => array(
				// 	'src'			=>	array('Type' => 'varchar(255)'),
				// 	'item_id'		=>	array('Type' => 'varchar(255)'),
				// 	'dimension'		=>	array('Type' => 'varchar(2)'),
				// ),
				'shop_inventory_attributes' => array(
					'item_id'		=>	array('Type' => 'int(8)'),
					'option'		=>	array('Type' => 'varchar(255)'),	
					'value'			=>	array('Type' => 'varchar(255)'), 
				), 
				'shop_orders'	=> array(
					'address_id'	=>	array('Type' => 'int(8)'),
					'user_id'		=>	array('Type' => 'int(8)'),
					'coupon_id'		=>	array('Type' => 'int(8)'),
					'timestamp'		=>  array('Type' => 'TIMESTAMP','Default'=>'CURRENT_TIMESTAMP')
				),
				'shop_carts'	=> array(
					'order_id' =>	array('Type' => 'int(8)'),
					'sku'      =>	array('Type' => 'varchar(100)'),
					'cents'    =>  array('Type' => 'int(12)'),
					'quantity' =>  array('Type' => 'int(8)')
				)

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

			$index['items_in_stock'] = $this->getTotalItems();
			$index['items_sold'] = $this->getTotalItems();
			$index['shop_sum']       = $this->sumTotalShop();
			$index['shop_sold']      = $this->sumTotalShop('$',true);

			return $index;
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
				$p['shelf']['stock'] = 1;
				$add = $q->Insert('shop_inventory_item',$p['shelf']);
			}else{
				$add = $q->Update('shop_inventory_item',$p['shelf'],array(
					'sku' =>  $p['shelf']['sku']
				));
			}


			if($add){
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
			$q    = $this->q();
			$item = $q->Select('sku','shop_inventory_item', array(
				'id'  => $p['shelf']['id']
			));
			$item = $item[0];
			
			$dir  = $this->_SET['upload_dir'].$this->shelvesDir;
			
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
					'item'  => $item
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
		function inventory($select='*',$tag=null){

			if(isset($_POST['shelf'])){
				return $this->updateShelf($_POST);
			}

			$t= $this->getTags();

			$q = $this->q();

			$l = ( isset($_GET['limit']) ) ? $_GET['limit'] : array(0,10);
			$l = ( isset($_POST['limit']) ) ? $_POST['limit'] : $l;



			$q->setStartLimit( $l[0], $l[1] );

			$where = ($tag) ? "tags LIKE '%$tag%' AND " : '';

			$i = $q->Select($select,'shop_inventory_item',$where." stock > -1" );

			// echo $q->mSql;
			// exit;

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
					'tags'		=> $t,
					'total'		=> $this->getTotalItems()
				),
				'start' => $l[0]+$l[1],
				'limit' => $l[1],
			);
		}

		public function getTotalItems()
		{
			return $this->q()->Count('shop_inventory_item',array('stock'=>'0'),'>');
		}

		public function sumTotalShop($cur='$',$sold=false)
		{
			$sum = 0; 

			$sold = ($sold) ? 'stock < 1' : null;

			foreach ( $this->q()->Select('price','shop_inventory_item', $sold) as $r => $c) {
				$sum = $sum + intval( str_replace($cur, '', $c['price']) );
			}

			return $sum;
		}

		function bazaar($tag=null)
		{

			$tag = str_replace('%20', ' ', $tag);

			$bazaar                 = $this->inventory('*',$tag);
			$bazaar['raw']          = (isset($_POST['limit']) || isset($_GET['ajax'])) ? true : false;
			$bazaar['basket_count'] = (isset($_SESSION['cart'])) ? count($_SESSION['cart']) : 0;
			$bazaar['cart']         =  $_SESSION['cart'] ;

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

		public function cart($s,$sku,$add=1)
		{
			switch ($s) {
				case 'add':
					$_SESSION['cart'][$sku]['quantity'] = (isset($_SESSION['cart'][$sku]['quantity'])) ? $_SESSION['cart'][$sku]['quantity'] + $add : 1;
				break;

				case 'remove': 
					if($add < 1){
						$_SESSION['cart'][$sku]['quantity']--;
					}else{
						unset($_SESSION['cart'][$sku]);						
					}
				break;
				
				default:
					# code...	
				break;
			}
		}


		/**
			@name checkout
			@desc Handles checkout process.
		**/
		public function checkout($action=null,$sku=null)
		{
			$q = $this->q();

			switch ($action) {
				// Default actions loads carts with images.
				default:
					$total = 0;
					foreach ($_SESSION['cart'] as $sku => $item) {
						$i = $q->Select('*','shop_inventory_item',array(
							'sku' => $sku
						));

						$price = intval(substr($i[0]['price'], 1));

						$_SESSION['cart'][$sku]['cents'] = $price & 100;

						$total = $price + $total;

						$items[] = $i[0];
					}

					$checkout['data']['total'] 	= $total;
					$checkout['data']['items'] 	= $items;
					$checkout['data']['pics'] 	= $this->getItemPics($items);
				break;

				case 'remove':
					$this->cart('remove', $sku);	// Remove item from cart
					$checkout = $this->checkout();	// Load Checkout.
				break;

				case 'pay':
					// We have an email associated with the payment; Lets Store it in our Users DB and get the user id.
					$user_id    = $this->idEmail($_POST['email']);
					// We also have an address, lets also create or return this id.
					$address_id = $this->idAddress($_POST['address'], $user_id);
					// Now that we have our id's let's make our order. 
					$checkout   = $this->placeOrder($user_id,$address_id);
				break;
			} 

			return $checkout; 
		}

		public function placeOrder($uid,$aid)
		{
			$q            = $this->q();
			$p            = $_POST;
			$p['user_id'] = $uid;
			$check        = $this->stripe($p);		// CHARGE USER

			if($check['success']){
				$check['order_id'] = $q->Insert('shop_orders',array(
					'user_id' 	 => $uid,
					'address_id' => $aid
				));

				// Order successfully placed and invoiced made. Add session cart to db cart
				foreach ($_SESSION['cart'] as $sku => $item) {
					$q->Insert('shop_carts', array(
						'order_id' => $check['order_id'],
						'sku'      => $sku,
						'cents'    => $item['cents'],
						'quantity' => $item['quantity']
					));
				}
			}

			return $check;
		}

		public function getTags()
		{
			foreach ($this->q()->Select('tags','shop_inventory_item','stock > -1') as $r => $c) {
				$tag = explode(",", $c['tags']); 
				foreach ($tag as $k => $v) { 
					foreach (explode(" ", $v) as $a => $t) {
						if(strlen($t) > 3){
							$tags[$t] = preg_replace('/[^a-zA-Z0-9_ %\[\]\.\(\)%&-]/s', '', $t);
						} 
					} 
				} 
			}

			asort($tags);

			return $tags;
		}

		public function thanks($order=0)
		{
			$q = $this->q();
 
			foreach ($_SESSION['cart'] as $k => $sku) { 
				$q->Inc('shop_inventory_item','stock',-1, array('sku'=>$k) );
				# code...
			}

			unset($_SESSION['cart']);

			$order['order_id'] = $order;

			$order = $q->Select('*','shop_orders',$order);

			$ship_to = $q->Select( '*','Addresses',array('id'=> $order['address_id']) );
			$ship_to = $ship_to[0];

			return array(
				'ship_to'	=> $ship_to,
				'data' 		=> $q->Select('shop_carts',array(
					'order_id' => $order['order_id']
				))
			);

		}
	}
?>