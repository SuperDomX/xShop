<div class="container main-content widget">
		<div class="row">
			<div class="col-xs-12">
				<div class="content">
					<h1>Your shopping cart</h1>
					
					{if $data|count == 0}
					<div class="empty-cart">
						<p class="lead">Your don't currently have any items in your cart.</p>
						<p>Please <a href="index.html">return to the shop</a>.</p>
					</div>
					{else}
					<form action="shopping-cart.php" method="post" class="shopping-cart" onsubmit="event.preventDefault();">
						<table class="table table-striped">
							<tbody>
							{foreach $data.items as $key => $item}
							<tr>
								<td class="img col-md-1">
									<div id="{$key}" class="carousel slide">
					                    <ol class="carousel-indicators outer">  
					                        {foreach $data.pics[$item.sku] as $p => $pic}
					                            {if $key} 
					                        <li data-target="#{$key}" {if $p==0}class="active"{/if} data-slide-to="{$p}"></li>    
					                            {/if}
					                        {/foreach} 
					                    </ol>
					                    <div class="carousel-inner text-align-center">
					                        <!-- {counter start=-1} -->
					                        {foreach $data.pics[$item.sku] as $p => $pic}
					                            <div class="item {if $p ==0}active{/if}"> 
					                            <img src="{$thumb}src=/{$UPLOAD}/shelves/{$item.sku}/{$pic}&w=250&h=125"> 
					                            {assign var=pic value="{$thumb}src=/{$toBackDoor}/_cfg/{$HTTP_HOST}/shelves/{$item.sku}/{$pic}&w=400"}
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
								</td>
								<td class="name col-md-8">
									<h3><a href="item/{$item.sku}">{$item.name}</a></h3>
								</td>
								<td class="price col-md-2">
									<h3><a href="#">{$item.price}</a></h3>
								</td>
								<td class="trash col-md-1">
									<h3><a href="/{$Xtra}/{$method}/remove/{$item.sku}"><i class="fa fa-trash-o"></i></a></h3>
								</td>
								<!-- <td class="size"><span class="size-small">M</span><span class="size-large">Medium</span></td> -->
								<!-- <td class="stock instock"><span class="stock-small"></span><span class="stock-large">In stock</span></td> -->
								<!-- <td class="quantity-cell">
									<a href="" class="quantity minus">-</a>
									<span class="order-quantity" data-sub="20">0</span>
									<a href="" class="quantity plus">+</a>									
								</td> -->
								<!-- <td class="sub-total"><span class="currency">$</span><span class="total">{$item.price|substr:1}</span></td> -->
								<!-- <td><a href="" class="cart-remove pull-right"><span class="remove-small">x</span><span class="remove-large">remove</span></a></td> -->
							</tr> 
							{/foreach}
							 					
							<!-- <tr class="cart-summary">
								<td colspan="2"></td>
								<td colspan="1" class="cart-total"><span class="currency">$</span><span class="total-total">
									</span>
								</td>
							</tr>	 -->
							<tr class="cart-summary">
								<td colspan="7">
									<button class="btn btn-bottom btn-block btn-success customButton">
										<h2>${$data.total}</h2>
									</button>
									<!-- <input class="btn" value="Checkout" /> -->
								</td>
							</tr>	
						</tbody></table>
						<input name="x[price]" type="hidden" value="{$xtra.price|substr:1}00" />
						<input name="x[class]" type="hidden" value="{$xtra.class}" /> 
					</form>
					<script src="https://checkout.stripe.com/checkout.js"></script>
 

					<script>
						 
					  var handler = StripeCheckout.configure({
						key   : '{$stripe_key}',
						image : '/square-image.png',
					    token: function(token) {
							// Use the token to create the charge with a server-side script.
							// You can access the token ID with `token.id`
							 
							token.amount = {$data.total};
							$.ajax({
								method : 'POST',
								url    : '/{$Xtra}/{$method}/pay/.json',
								data   : token,
								type   : 'json',
								success : function  (data) {

									if(data.success){
										
									} else{
										alert(data.error);
									}
								}
							});
							window.location.href = '/{$Xtra}/thanks/';
					    }
					  });

					  $('.customButton').on('click', function(e) {
					    // Open Checkout with further options
					    handler.open({
							name        : "{$HTTP_HOST}",
							description : "{$site_name}",
							amount      :  100 * {$data.total}
						});
					    e.preventDefault();
					  });
					</script> 


					<div class="shopping-cart-help">
						<p>Update or remove items from your cart before proceeding to checkout to calculate delivery cost and use any exclusive discount codes.</p>										
						<p>
							<small><span class="instock">Instock</span> Item in stock and will be dispatched normally.</small><br>
							<small><span class="lowstock">Low stock</span> Low item stock. Additional delay might exist is dispatching your item, delays will be notified by email.</small><br>
							<small><span class="outofstock">Out of stock</span> Item is out of stock and will be placed on back order and fulfilled as soon as possible.</small>
						</p>
					</div>
					{/if}
				</div>			
			</div> <!-- // end span12 -->
		</div> <!-- //end row -->
	</div>
