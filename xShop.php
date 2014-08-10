<?php
/**
 * @name Shop
 * @desc Online Web Shop
 * @version v1(1.6)
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
					'stock'			=>	array('Type' => 'int(8)'),
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
		
		function autoRun(){
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
			@filter catalog
			@icon book
		**/
		function inventory($select='*'){
			if(isset($_POST['shelf'])){
				return $this->updateShelf($_POST);
			}

			$q = $this->q();

			$l = ( isset($_GET['limit']) ) ? $_GET['limit'] : array(0,10);
			$q->setStartLimit( $l[0], $l[1] );
			$i = $q->Select($select,'shop_inventory_item');

			foreach ($i as $key => $value) { 
				$dir = $this->_SET['upload_dir'].$this->shelvesDir.$value['sku'];
				
				if(!is_dir($dir)){
					// Items are organized in the databased based on their SKUs
					// If an item isnt found on the shelf. it's taken out of the database to avoid errors...
					$q->Delete('shop_inventory_item',array(
						'id' => $value['id']
					));
					unset($i[$key]);
				}else{
					$pics[$value['sku']] = scandir($dir);
				
					unset($pics[$value['sku']][0]);
					unset($pics[$value['sku']][1]); 
					
					$pics[$value['sku']] = array_values($pics[$value['sku']]);
				}
			}

			return array(
				'data' => array(
					'pics'      => $pics,
					'inventory' => $i
				)
			);
		}

		function bazaar($value='')
		{
			return $this->inventory();
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

	}

?>