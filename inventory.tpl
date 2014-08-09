{$col = [4]}
 
<div class="row">
 	{counter start=0 assign=count} 
    {foreach $data.inventory as $key => $item} 
		{assign var=rand value=$col|@array_rand}
	<div class="col-md-{$col[$rand]}"> 
        <div class="panel product {$item.hash} {if $count == 0}active{/if}" id="product-{$item.sku}">
       	 
			<div class="media"> 
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
                            <img src="{$thumb}w=640&src=/{$toBackDoor}/_cfg/{$HTTP_HOST}/shelves/{$item.sku}/{$pic}">
	                        </div> 
                        {/foreach} 
                    </div>
                    <a class="left carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="prev">
                        <i class="fa fa-angle-left"></i>
                    </a>
                    <a class="right carousel-control" style="width: 50px; z-index: 100" href="#{$key}" data-slide="next">
                        <i class="fa fa-angle-right"></i>
                    </a>
                </div>


				<span class="plabel">
					<p class="name panel">
						{$item.name}
					</p>
					<h1 class="price panel"><!-- <span class="cur">$</span> --><span class="total">{$item.price}</span></h1>
				</span>				
			</div>
			<div class="form-group no-margin">  
				<form action="/{$toBackDoor}/{$Xtra}/{$method}/.json" id="form-{$item.sku}" method="POST" onsubmit="return window.addToShelf(this,event);"> 
					<div class="input-group input-group-lg">
						<span class="input-group-addon">
                            <i class="fa fa-cube"></i>
                        </span>
						<input type="text" class="input-sm form-control  input-transparent" onkeyup="$('#product-{$item.sku} p.name').html(this.value);" value="{$item.name}" name="shelf[name]">

					</div >
					<div class="input-group input-group-lg">
						<span class="input-group-addon">
                            <i class="fa fa-money"></i>
                        </span>
						<input type="text" class="input-sm form-control  input-transparent" onkeyup="$('#product-{$item.sku} h1 .total').html(this.value);" value="{$item.price}" name="shelf[price]">
					</div>
					<div class="input-group input-group-lg">
						<span class="input-group-addon">
                            <i class="fa fa-barcode"></i>
                        </span>
						<input type="text" class="input-sm form-control  input-transparent" value="{$item.sku}" name="shelf[sku]">
					</div>
					<div class="input-group input-group-lg">
						<span class="input-group-addon">
	                            <i class="fa fa-tag"></i>
	                        </span>
							<input type="text" class="input-sm form-control  input-transparent" value="{$item.name}" name="shelf[tags]">
					</div> 

					<button class="btn btn-bottom btn-success qadd" type="submit">
						<i class="glyphicon glyphicon-cloud-upload"></i> Update Shelf
					</button>	
				</form>
			</div>
		</div> 
	{counter}
</div>
    {/foreach}

</div>
 <script type="text/javascript">



	window.addToShelf = function (f,e) { 

        
		dataString = $(f).serialize();

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
<script src="{$WT}js/bootstrap.js"></script>
<script src="{$WT}js/shopfrog.js"></script>


<script src="{$WT}js/shopfrog.js"></script>