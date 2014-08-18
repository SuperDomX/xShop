<div class="jumbotron col-md-12"> 
	
	{if $data.shelf > 0}
 	{counter start=0 assign=count}
    {foreach $data.shelf as $key => $item} 
        <div class="panel product {$item.hash} {if $count == 0}active{/if}" id="product-{$item.sku}"> 
			<div class="media"> 
				<img src='/{$UPLOAD}{$shop.dir.imports}{$item.pic}' alt="product title" data-img="product-{$count}" class="img-responsive" />
				<span class="plabel">
					<p class="name panel">
						{$item.name}
					</p>
					<h1 class="price panel"><!-- <span class="cur">$</span> --><span class="total">{$item.cost}</span></h1>
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
						<input type="text" class="input-sm form-control  input-transparent" onkeyup="$('#product-{$item.sku} h1 .total').html(this.value);" value="{$item.cost}" name="shelf[price]">
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
					<i class="glyphicon glyphicon-cloud-upload"></i>
						Add to Shelf</button>	
				</form>
			</div>
		</div> 
	{counter}
    {/foreach}
    {else}
    	<h2>Nothing to clean...</h2>
    {/if}
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

				Messenger().post({
					showCloinseButton : true,
					type            : 'success',
					message         : '<i class="fa fa-check"></i> Item Successfully Imported'
				});

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