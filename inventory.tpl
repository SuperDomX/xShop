{include file="~widgets/billboard.tpl"}
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
                            <img src="{$thumb}w=640&src=/{$UPLOAD}/shelves/{$item.sku}/{$pic}">
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
				<form action="/{$toBackDoor}/{$Xtra}/{$method}/.json" id="form-{$item.sku}" method="POST" onsubmit="return window.updateShelf(this,event);"> 
					<div class="input-group input-group-lg">
						<span class="input-group-addon btn-info disabled">
                            <i class="fa fa-cube"></i>
                        </span>
						<input type="text" class="input-sm form-control  input-transparent" onkeyup="$('#product-{$item.sku} p.name').html(this.value);" value="{$item.name}" name="shelf[name]">

					</div >
					<div class="input-group input-group-lg">
						<span class="input-group-addon btn-success disabled">
                            <i class="fa fa-dollar"></i>
                        </span>
						<input type="text" class="input-sm form-control  input-transparent" onkeyup="$('#product-{$item.sku} h1 .total').html(this.value);" value="{$item.price|replace:'$':''}" name="shelf[price]">
						<span class="input-group-addon">
                            .00
                        </span>
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
							<input type="text" class="input-sm form-control  input-transparent" value="{$item.tags}" name="shelf[tags]">
					</div> 
					<div class="input-group input-group-lg">
						<span class="input-group-addon">
	                            <i class="fa fa-cubes"></i>
                        </span>
                        <!-- {$s = "stock-{$item.id|md5|substr:0:3}" } -->
						<input type="text" id="{$s}" class="input-sm form-control  input-transparent" value="{$item.stock}" name="shelf[stock]">
						<span class="input-group-btn" >
					        <a class="btn btn-success btn-block" type="button" onclick="$('#{$s}').val(1+parseInt($('#{$s}').val()))"  >
					             <i class="fa fa-plus-square" ></i>
					        </a>
					    </span>
					    <span class="input-group-btn" >
					        <a  class="btn btn-danger btn-block" onclick="$('#{$s}').val(-1+parseInt($('#{$s}').val()))" type="button"   >
					             <i class="fa fa-minus-square" ></i>
					        </a>
					    </span>
					</div> 

					<button class="btn btn-bottom btn-lg btn-success qadd" type="submit">
						<i class="glyphicon glyphicon-cloud-upload"></i> Update Shelf
					</button>	
					<button class="btn btn-bottom  btn-warning">
						<i class="fa fa-ban"></i> Discontinue
					</button>	
					<button class="btn btn-bottom btn-sm btn-danger">
						<i class="glyphicon glyphicon-cloud-download"></i> Remove from Shelf
					</button>	
					<input type="hidden" value="{$item.id}" name="shelf[id]">
				</form>
			</div>
		</div> 
	{counter}
</div>
    {/foreach}
   
	<div class="load-more-container">
		<button class="btn btn-block btn-success load-more">
			Next Page <i class="fa fa-forward"></i>
		</button>
	</div> 
</div>
 <script type="text/javascript">



	window.updateShelf = function (f,e) { 

        
		dataString = $(f).serialize();

		$.ajax({
			type     : "POST",
			url      : $(f).attr("action"),
			data     : dataString,
			dataType : "json",
			success: function(data)
			{
				var m;

				if(data.error){
					m = {
						showCloseButton : true,
						type            : 'error',
						message         : '<i class="fa fa-ban"></i> '+data.error
					};
				}else{
					m = {
						showCloseButton : true,
						type            : 'success',
						message         : '<i class="fa fa-check"></i> Item Successfully Updated'
					};
				};

				Messenger().post(m);
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