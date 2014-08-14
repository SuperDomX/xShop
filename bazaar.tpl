{if !$raw}
<link rel="stylesheet" type="text/css" href="/x/html/layout/watchtower/css/shopfrog.css">
<!-- <link rel="stylesheet" type="text/css" href="/x/html/layout/watchtower/css/shopfrog-grey.css"> -->

<style type="text/css">
	.medium .carousel-indicators li{
		width: 5px;
		height: 5px;
	}

</style>

<div id="product-board">

		<div class="product large static">
			<div class="text">
				<h1>{$shop_name}</h1>
				<p class="lead">
					{$shop_intro}
				</p>
				
				<p class="filter">Tags:</p>
								
				<ul class="board-links clearfix">
					{foreach $data.tags as $t => $tag}
						<li class='current'>
							<a class='current' href="/{$Xtra}/{$method}/{$tag}/">{$tag}</a>
						</li>
					{/foreach}  
				</ul>
				
				<!-- <p class="filter">Filter:</p>		
				<ul class="board-filters clearfix">
					<li><a href="" class="filter-hidden" data-filter="all">all</a></li>					
					<li><a href="" data-filter="cat-1">black</a></li>
					<li><a href="" data-filter="cat-2">red</a></li>
					<li><a href="" data-filter="cat-3">plain</a></li>
					<li><a href="" data-filter="cat-4">patterned</a></li>
					<li><a href="" data-filter="cat-5">new in</a></li>					
				</ul>	 -->			
			</div>
		</div>
{/if}		
		<!--
			Products
			--------
			Each item on the product board is identified by the 'product' class.
			There are two size variations, identified by the classes 'medium' or 'large'.
			
			Details expansion:
			The details expansion is operated by an id. 
			The 'details-extra' div has an id, eg: 'details-0001'
			This is paired with the anchor tag with class 'details-expand' which has a matching data-target of that id.
		-->

{$col = ['large','medium']}
	{counter start=0 assign=count} 
    {foreach $data.inventory as $key => $item} 
		{assign var=rand value=$col|@array_rand}
		      
		<div class="product {$col[$rand]} cat-{$item.hash}" id="product-{$item.sku}">
			<form class="form-inline"  action="/{$Xtra}/checkout/"  onsubmit="return false;"  method="POST"> 
			<div class="media">
				
				<a href="item/{$item.sku}" title="">
				<div id="{$key}" class="carousel slide">
                    <ol class="carousel-indicators outer">  
                        {foreach $data.pics[$item.sku] as $p => $pic}
                            {if $key} 
                        <li data-target="#{$key}" {if $p==0}class="active"{/if} data-slide-to="{$p}"></li>    
                            {/if}
                        {/foreach} 
                    </ol>
                    <div class="carousel-inner text-align-center">
                         {counter start=-1}
                        {foreach $data.pics[$item.sku] as $p => $pic}
                            <div class="item {if $p ==0}active{/if}"> 
                            <img src="{$thumb}src=/{$UPLOAD}/shelves/{$item.sku}/{$pic}&w=800&h=600"> 
                            {assign var=pic value="{$thumb}src=/{$toBackDoor}/_cfg/{$HTTP_HOST}/shelves/{$item.sku}/{$pic}&w=400"}
	                        </div> 
                        {/foreach} 
                    </div>
                    {if {$col[$rand]}=='medium'}
                     <a class="left carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="prev">
                        
                        <i class="fa fa-angle-left"></i>
                        
                    </a>
                    <a class="right carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="next">
                        <i class="fa fa-angle-right"></i>
                    </a>
                    {else}
	<a class="left carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="prev">
                        
                        <i class="glyphicon glyphicon-chevron-left"></i>
                        
                    </a>
                    <a class="right carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="next">
                        <i class="glyphicon glyphicon-chevron-right"></i>
                    </a>



                   {/if}
                   
                </div>


				
				</a>

				<span class="plabel" >
					<p class="name panel">{$item.name}</p>  
					<h2  class="total price panel">{$item.price}</h2>
				</span>	 

				<!-- <h1 class="price panel"><span class="cur">$</span></h1> -->
				<!-- <span class="plabel">just in</span>				 -->
				</div>
				<div class="details">
					<!-- <p class="name"><a href="product.html">StrappyFrog Classic</a></p>
					<p class="price"><span class="cur">$</span><span class="total">25.00</span></p>
					 -->
					 <a href=""  class="details-expand" data-target="details-{$item.sku}"><b>+</b>
					 <!-- <i class="fa fa-shopping-cart fa-2x"></i> -->
					 </a>
					 <a href=""  class="details-expand" data-target="details-{$item.sku}"><b>+</b>
					 <!-- <i class="fa fa-shopping-cart fa-2x"></i> -->
					 </a>
				</div><div class="details">
					<!-- <p class="name"><a href="product.html">StrappyFrog Classic</a></p>
					<p class="price"><span class="cur">$</span><span class="total">25.00</span></p>
					 -->
					 <a href=""  class="details-expand" data-target="details-{$item.sku}"><b>+</b>
					 <!-- <i class="fa fa-shopping-cart fa-2x"></i> -->
					 </a>
					 <a href=""  class="details-expand" data-target="details-{$item.sku}"><b>+</b>
					 <!-- <i class="fa fa-shopping-cart fa-2x"></i> -->
					 </a>
				</div>

				<div class="details-extra" id="details-{$item.sku}">
					
					<button class="btn btn-bottom btn-atc btn-info" onclick="window.addToCart(this);" ><i class="fa fa-shopping-cart"></i> Add to Cart<!--  {$item.price} --></button>			
					<!-- 
			{counter}  -->
				</div>
			</form> 
		</div>
    {/foreach}
		<!--  
	
		onclick='window.purchase(event,{ name : "{$item.name}", price : "{$item.price}" })'

		<div class="product medium cta alt static">
			<a class='current' href="collection.html">
				<div class="content">
					<p class="poff">20% <br /> off!</p>
					<p>All accessories &rarr;</p>
				</div>
			</a>
		</div>
		
		 	
		
		<div class="product medium cta static">
			<a href="">
				<div class="content">
					<p class="poff">Like <br /> us!</p>
					<p>on facebook &rarr;</p>
				</div>
			</a>
		</div>	 -->	
		
	 {assign var="WT" value="/x/html/layout/watchtower/"}

{if !$raw}
	</div> <!-- //end product-board -->
	
	<div class="load-more-container">
		<button class="btn load-more">
			load more
		</button>
	</div> 
  <style type="text/css">
	.panel{
		background-color: rgba(0,0,0,0.25);
	}
 </style>
<script type="text/javascript">


	var h1 = $('<h1/>',{
		class : ''
	});

	var badge = $('<span/>',{
		id    : 'cart-badge',
		class : 'badge badge-success pull-right basket-count',
		style : 'margin-bottom : -5px; margin-right : 25px',
		text  : {$basket_count}
	}).appendTo(h1);
	var cart = $('<i/>',{
		class : 'fa fa-shopping-cart pull-left'
	}).appendTo(h1);

	var fix = $('<a/>', { 
		style : 'position: fixed; bottom: 15px; right: 25px;  border-radius: 300px; z-index: 999999999999',
		class : 'btn btn-success',
		href  : '/{$Xtra}/checkout'
	}).appendTo('body');
 
 	h1.appendTo(fix);
 
	window.addToShelf = function (f,e) {  

		var dataString = $(f).serialize(); 
		$.ajax({
			type     : "POST",
			url      : $(f).attr("action"),
			data     : dataString,
			dataType : "json",
			success: function(data)
			{
				var p = $(f).attr('id').replace('form','product');
				$('#'+p).fadeOut();
				// Handle the server response (display errors if necessary)

				//  $.pjax({

				// container : '.content',
				// fragment  : '.content',
				// timeout   : 5000,
				// url       : window.location.pathname+window.location.search+window.location.hash
				//  });

			}
		});
		e.preventDefault(); 
	};

	window.page = {
		start : {$start},
		limit : {$limit}
	};

	// Load more on product boards via AJAX
	$(document).on('click', '.load-more', function(){
		curLabel = $(this).html();
		$(this).html('loading...');
	
		$.ajax({
			type    : 'GET',
			url     : "/{$toSideDoor}/{$Xtra}/{$method}/{$params}/{$params[2]}/&ajax&limit[]="+window.page.start +"&limit[]="+window.page.limit ,
			context : $(this)
		}).done(function(response) {
			$(this).html(curLabel);
			var $container = $('#product-board');	
			var $newElements = $(response).filter('div');
			$newElements.css({ opacity:0 });
			$container.append( $newElements );
			
			$newElements.imagesLoaded(function() { 
				$newElements.css({ opacity:1 });			
				$container.masonry('appended', $newElements);
			});
		});
		window.page.start = window.page.start + window.page.limit;
	});

	window.addToCart = function (btn) {
		$product = $(btn).parent().parent();
		var newItem = '';
		var count = $('.basket-count').html().toString();
		count = parseFloat(count);
		count++; 

		$('.basket-count').html(
			count
		); 
		$('<div class="added-to-basket"><i class="fa fa-check"></i> Added to cart</div>').appendTo($product).delay(1500).fadeOut(1500);		

		$.ajax({
			url : '/{$Xtra}/cart/add/'+ $product.parent().attr('id').replace('product-',''),
			success : function () {
				//Messenger().post("SuperDom Successfully Loaded");
			}
		});
	}

</script>
	
	<link href="{$WT}css/rateit.css" rel="stylesheet" media="screen">		       
	<link href="{$WT}css/magnific-popup.css" rel="stylesheet"> 		
	<script src="{$WT}js/respond.min.js"></script> 
	<link href='//fonts.googleapis.com/css?family=PT+Sans' rel='stylesheet' type='text/css'>
	<link href='//fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
	<script src="{$WT}js/imagesloaded.min.js"></script>	
	<script src="{$WT}js/jquery.masonry.min.js"></script>	
	<script src="{$WT}js/jquery.rateit.min.js"></script>		<!-- 
	<script src="{$WT}s/jquery.magnific-popup.min.js"></script>			 -->	
	
{/if}
<script src="{$WT}js/bootstrap.js"></script>

<script type="text/javascript" type="text/javascript" src="/x/html/layout/watchtower/lib/bootstrap/carousel.js"></script>
<script type="text/javascript" src="{$WT}js/shopfrog.js"></script>
