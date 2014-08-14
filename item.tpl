<link rel="stylesheet" type="text/css" href="/x/html/layout/watchtower/css/shopfrog.css">
<link rel="stylesheet" type="text/css" href="/x/html/layout/watchtower/shopfrog-grey.css">

<div class="container product-main widget">
		{foreach $data.product as $key => $item}
						
		<div class="row">

			<div class="col-sm-7">
				<div class="content">

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
	                            <!-- <img src="{$thumb}src=/{$UPLOAD}/shelves/{$item.sku}/{$pic}&w=1024">  -->
	                            <img src="/{$UPLOAD}/shelves/{$item.sku}/{$pic}">
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
	                <button class="btn btn-bottom btn-info" onclick='window.history.back();'><i class="fa fa-backward"></i> Go Back</button>
				</div>

			</div> <!-- // end span6 -->

			<div class="col-sm-5">
				<div class="content">
					
					<!-- Product information for large screens -->
					<div class="product-details-large">
						<!-- Product name and manufacturer -->
						<h1>{$item.name}</h1>
						<!-- <small>by <a href="">Frogtastic</a></small> -->

						<!-- Product rating and review info -->
						<!-- <div class="ratings clearfix">
							<div class="rateit" data-rateit-value="4.6" data-rateit-ispreset="true" data-rateit-readonly="true"><div class="rateit-reset" style="display: none;"></div><div class="rateit-range" style="width: 80px; height: 16px;"><div class="rateit-selected rateit-preset" style="height: 16px; width: 73.6px;"></div><div class="rateit-hover" style="height:16px"></div></div></div>
							<div class="extra">
								<a href="#reviews">Read all 10 reviews</a> | <a href="review-product.html">Write a review</a>
							</div>
						</div> -->
					
						<!-- Pricing and offer info -->
						<!-- <div class="pricing clearfix">
							<p class="price"><span class="cur">$</span><span class="total">{$item.price|substr:1}</span> 
							 
							</p> 
						</div> -->

					<div class="container text-align-center">
						<!-- Share -->
						<!-- <ul class="share">
							<li>
								<iframe id="twitter-widget-0" scrolling="no" frameborder="0" allowtransparency="true" src="http://platform.twitter.com/widgets/tweet_button.1406859257.html#_=1407729894881&amp;count=none&amp;id=twitter-widget-0&amp;lang=en&amp;original_referer=http%3A%2F%2Fleapfrogui.com%2Fshopfrog%2Fgrey%2Fproduct.html&amp;size=m&amp;text=Shopfrog%20-%20Modern%20Ecommerce&amp;url=http%3A%2F%2Fleapfrogui.com%2Fshopfrog%2Fgrey%2Fproduct.html" class="twitter-share-button twitter-tweet-button twitter-share-button twitter-count-none" title="Twitter Tweet Button" data-twttr-rendered="true" style="width: 56px; height: 20px;"></iframe>
							</li>
							<li>
								<div id="___plusone_0" style="text-indent: 0px; margin: 0px; padding: 0px; background-color: transparent; border-style: none; float: none; line-height: normal; font-size: 1px; vertical-align: baseline; display: inline-block; width: 32px; height: 20px; background-position: initial initial; background-repeat: initial initial;"><iframe frameborder="0" hspace="0" marginheight="0" marginwidth="0" scrolling="no" style="position: static; top: 0px; width: 32px; margin: 0px; border-style: none; left: 0px; visibility: visible; height: 20px;" tabindex="0" vspace="0" width="100%" id="I0_1407729894925" name="I0_1407729894925" src="https://apis.google.com/u/0/se/0/_/+1/fastbutton?usegapi=1&amp;size=medium&amp;annotation=none&amp;origin=http%3A%2F%2Fleapfrogui.com&amp;url=http%3A%2F%2Fleapfrogui.com%2Fshopfrog%2Fgrey%2Fproduct.html&amp;gsrc=3p&amp;ic=1&amp;jsh=m%3B%2F_%2Fscs%2Fapps-static%2F_%2Fjs%2Fk%3Doz.gapi.en.qcxXvkaohGw.O%2Fm%3D__features__%2Fam%3DEQ%2Frt%3Dj%2Fd%3D1%2Ft%3Dzcms%2Frs%3DAItRSTMiQ3DliY8yGP7oSyUhTCaOu3Fc5Q#_methods=onPlusOne%2C_ready%2C_close%2C_open%2C_resizeMe%2C_renderstart%2Concircled%2Cdrefresh%2Cerefresh%2Conload&amp;id=I0_1407729894925&amp;parent=http%3A%2F%2Fleapfrogui.com&amp;pfname=&amp;rpctoken=18827926" data-gapiattached="true" title="+1"></iframe></div>
							</li>
							<li>
								<a class="PIN_1407729895220_pin_it_button_20 PIN_1407729895220_pin_it_button_en_20_gray PIN_1407729895220_pin_it_button_inline_20 PIN_1407729895220_pin_it_beside_20" data-pin-href="//www.pinterest.com/pin/create/button/?url=http%3A%2F%2FPAGEURL&amp;media=http%3A%2F%2FIMAGE&amp;guid=sxzhcDYmAWyv-0&amp;description=DESCRIPTION" data-pin-log="button_pinit" data-pin-config="beside"><span class="PIN_1407729895220_hidden" id="PIN_1407729895220_pin_count_0"><i></i></span></a>
							</li>
							<li>
								<div class="fb-like fb_iframe_widget" data-href="PAGEURL" data-send="false" data-width="120" data-show-faces="false" data-layout="button_count" fb-xfbml-state="rendered" fb-iframe-plugin-query="app_id=&amp;href=http%3A%2F%2Fleapfrogui.com%2Fshopfrog%2Fgrey%2FPAGEURL&amp;layout=button_count&amp;locale=en_US&amp;sdk=joey&amp;send=false&amp;show_faces=false&amp;width=120"><span style="vertical-align: bottom; width: 76px; height: 20px;"><iframe name="f112cb22c4" width="120px" height="1000px" frameborder="0" allowtransparency="true" scrolling="no" title="fb:like Facebook Social Plugin" src="http://www.facebook.com/plugins/like.php?app_id=&amp;channel=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter%2FoDB-fAAStWy.js%3Fversion%3D41%23cb%3Df3122c56f8%26domain%3Dleapfrogui.com%26origin%3Dhttp%253A%252F%252Fleapfrogui.com%252Ff23d24f008%26relation%3Dparent.parent&amp;href=http%3A%2F%2Fleapfrogui.com%2Fshopfrog%2Fgrey%2FPAGEURL&amp;layout=button_count&amp;locale=en_US&amp;sdk=joey&amp;send=false&amp;show_faces=false&amp;width=120" style="border: none; visibility: visible; width: 76px; height: 20px;" class=""></iframe></span></div>
							</li>
						</ul> -->
					</div>
					</div>
					
					<!-- Review ratings breakdown -->
					<br/>
					<!-- <div class="review-overview">
						<div class="content clearfix">
							<h3>Reviews</h3>
							
							
							<ul class="review-totals">
								<li>
									<p>5 star</p>
									<div class="meter">
										<span style="width: 50%"></span>
									</div>
									<p>5</p>
								</li>
								<li>
									<p>4 star</p>
									<div class="meter">
										<span style="width: 30%"></span>
									</div>
									<p>3</p>
								</li>
								<li>
									<p>3 star</p>
									<div class="meter">
										<span style="width: 20%"></span>
									</div>
									<p>2</p>
								</li>
								<li>
									<p>2 star</p>
									<div class="meter">
										<span style="width: 0%"></span>
									</div>
									<p>0</p>
								</li>
								<li>
									<p>1 star</p>
									<div class="meter">
										<span style="width: 0%"></span>
									</div>
									<p>0</p>
								</li>
							</ul>
								 
							<div class="review-main">
								<div class="rateit bigstars" data-rateit-value="4.6" data-rateit-ispreset="true" data-rateit-readonly="true" data-rateit-starwidth="32" data-rateit-starheight="32"><div class="rateit-reset" style="display: none;"></div><div class="rateit-range" style="width: 160px; height: 32px;"><div class="rateit-selected rateit-preset" style="height: 32px; width: 147.2px;"></div><div class="rateit-hover" style="height:32px"></div></div></div>
								<p>4.6 out of 5 stars from 10 reviews</p>
								<p><a href="review-product.html" class="btn"><i class="icon-pencil icon-white"></i> write a review</a></p>
							</div>
						</div>
					</div> -->
					<ul class="nav nav-tabs" id="product-tabs">
						<li class="active"><a href="#description">Description</a></li>
						<li><a href="#care">Physics</a></li>
						<li><a href="#sizing">Meta Physics</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="description">
							<p>Coming Soon!</p>
						</div>
						<div class="tab-pane" id="care">
							<p>Rinse your swimsuit in cold water after use and allow it to dry naturally, away from direct heat and sunlight.</p>
							<p>After rinsing out the suit, you must wash your suit. Plain water does not remove all the salt or chlorine. Fill a sink with water and add just a tablespoon or less of liquid detergent. Don't use powders because they may not dissolve completely or rinse away well. And, never use bleach. Turn your swimsuit inside out. Swish for several minutes and then rinse well. Gently squeeze - don't wring - the water out of the fabric. Spread your suit flat to dry in a spot out of direct sunlight.</p>
						</div>
						<div class="tab-pane" id="sizing">
							<p>Standard swim suit sizing comes in S/M/L and come in Body measurements are given in inches. If your body measurement is on the borderline between two sizes, order the lower size for a tighter fit or the higher size for a looser fit.</p>
							<p>If your body measurements for hip and waist result in two different suggested sizes, order the size from your hip measurement. </p>
							<table class="table table-striped table-bordered">
								<tbody><tr>
									<th></th><th>Size</th><th>Bust (in)</th><th>Ribcage (in)</th><th>Waist (in)</th><th>Hip (in)</th><th>Torso (in)</th>
								</tr>
								<tr>
									<td rowspan="2">S</td><td>4</td><td>33 1/2</td><td>27</td><td>25 1/2</td><td>35 1/2</td><td>58 1/2</td>
								</tr>
								<tr>
									<td>6</td><td>34 1/2</td><td>28</td><td>26 1/2</td><td>36 1/2</td><td>60</td>
								</tr>
								<tr>
									<td rowspan="2">M</td><td>8</td><td>35 1/2</td><td>29</td><td>27 1/2</td><td>37 1/2</td><td>61 1/2</td>
								</tr>
								<tr>
									<td>10</td><td>36 1/2</td><td>30</td><td>28 1/2</td><td>38 1/2</td><td>63</td>
								</tr>
								<tr>
									<td rowspan="2">L</td><td>12</td><td>38</td><td>31 1/2</td><td>30</td><td>40</td><td>64 1/2</td>
								</tr>
								<tr>
									<td>14</td><td>39 1/2</td><td>33</td><td>31 1/2</td><td>41 1/2</td><td>66</td>
								</tr>
							</tbody></table>
						</div>
					</div>
					
					<!-- Product options -->
					<form class="form-inline clearfix cart"  action="/{$toBackDoor}/{$Xtra}/{$xtra.class}/" onsubmit="return false;" method="POST">
		    
						<!-- <div>
							<label>Quantity</label>	
							<input type="text" class="input-sm form-control">
						</div>
						<div>
							<label>Size</label>
							<select class="input-sm form-control">
								<option>S</option>
								<option>M</option>
								<option>L</option>										
							</select>
						</div>	 -->						
						<input name="x[price]" type="hidden" value="{$xtra.price|substr:1}00" />
						<input name="x[class]" type="hidden" value="{$xtra.class}" /> 
						<script src="https://checkout.stripe.com/checkout.js"></script> 
					 
					<button class="btn btn-bottom btn-atc qadd btn-success" onclick='window.purchase(event,{ name : "{$item.name}", price : "{$item.price}" })'>
						<i class="fa fa-shopping-cart"></i> Buy Now <b>{$item.price}</b></button>		
						<!-- <button class="btn btn-large btn-atc">Add to cart</button> -->
					</form>
					<script type="text/javascript">
						var handler = StripeCheckout.configure({
						    key: '{$stripe_key}',
						    image: '{$pic}',
						    token: function(token) {
						      // Use the token to create the charge with a server-side script.
						      // You can access the token ID with `token.id`
						    }
						});
						window.purchase = function(e,item) {
						    // Open Checkout with further options
						    handler.open({
						      name: "{$HTTP_HOST}",
						      description: item.name + ' ' + item.price,
						      amount: 100 * item.price.replace('$','')
						    });
						    e.preventDefault();
						  }; 
					</script>
					
					
				</div>
			</div> <!-- // end span6 -->
			
		</div> <!-- //end row -->

		{/foreach}
		<div class="row" id="reviews">
			<div class="col-xs-12">
				

				<!-- <div class="product-review">
					<div class="row">
						<div class="col-sm-8">
							<div class="content">
								<header>
									<div class="rateit" data-rateit-value="4.5" data-rateit-ispreset="true" data-rateit-readonly="true"><div class="rateit-reset" style="display: none;"></div><div class="rateit-range" style="width: 80px; height: 16px;"><div class="rateit-selected rateit-preset" style="height: 16px; width: 72px;"></div><div class="rateit-hover" style="height:16px"></div></div></div>
									<p><strong>Perfect, just what I wanted!</strong></p>
								</header>
								
								<p>Bacon ipsum dolor sit amet t-bone corned beef brisket, chicken rump jerky meatloaf venison andouille ground round pig beef shankle pork. Pork loin tenderloin flank, swine rump chicken sausage leberkas pig biltong pancetta tongue tail bresaola. Biltong pastrami jerky, capicola brisket sausage ribeye drumstick shoulder leberkas beef sirloin. Strip steak fatback drumstick tri-tip corned beef bresaola.</p>
								
								<footer>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-thumbs-up"></span> helpful</a>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-thumbs-down"></span> unhelpful</a>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-pencil"></span> comment</a>
									<a href="" class="report"><span class="glyphicon glyphicon-ban-circle"></span></a>
								</footer>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="content review-author">
								<div class="top-contrib">Top contributor</div>
								<p><a href="user-profile.html">SFShopper</a></p>
								<small>June 30th, 2013</small>	
								<p>An avid shopper, love buying my stuff from Shopfrog. <a href="user-profile.html">Read all my reviews →</a></p>
							</div>
						</div>
					</div>
				</div>
							
				<div class="product-review">
					<div class="row">
						<div class="col-sm-8">
							<div class="content">
								<header>
									<div class="rateit" data-rateit-value="4.5" data-rateit-ispreset="true" data-rateit-readonly="true"><div class="rateit-reset" style="display: none;"></div><div class="rateit-range" style="width: 80px; height: 16px;"><div class="rateit-selected rateit-preset" style="height: 16px; width: 72px;"></div><div class="rateit-hover" style="height:16px"></div></div></div>
									<p><strong>Perfect, just what I wanted!</strong></p>
								</header>
								
								<p>Bacon ipsum dolor sit amet t-bone corned beef brisket, chicken rump jerky meatloaf venison andouille ground round pig beef shankle pork. Pork loin tenderloin flank, swine rump chicken sausage leberkas pig biltong pancetta tongue tail bresaola. Biltong pastrami jerky, capicola brisket sausage ribeye drumstick shoulder leberkas beef sirloin. Strip steak fatback drumstick tri-tip corned beef bresaola.</p>
								
								<footer>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-thumbs-up"></span> helpful</a>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-thumbs-down"></span> unhelpful</a>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-pencil"></span> comment</a>
									<a href="" class="report"><span class="glyphicon glyphicon-ban-circle"></span></a>
								</footer>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="content review-author">
								<div class="top-contrib">Top contributor</div>
								<p><a href="user-profile.html">SFShopper</a></p>
								<small>June 30th, 2013</small>	
								<p>An avid shopper, love buying my stuff from Shopfrog. <a href="user-profile.html">Read all my reviews →</a></p>
							</div>
						</div>
					</div>
				</div>
							
				<div class="product-review">
					<div class="row">
						<div class="col-sm-8">
							<div class="content">
								<header>
									<div class="rateit" data-rateit-value="4.5" data-rateit-ispreset="true" data-rateit-readonly="true"><div class="rateit-reset" style="display: none;"></div><div class="rateit-range" style="width: 80px; height: 16px;"><div class="rateit-selected rateit-preset" style="height: 16px; width: 72px;"></div><div class="rateit-hover" style="height:16px"></div></div></div>
									<p><strong>Perfect, just what I wanted!</strong></p>
								</header>
								
								<p>Bacon ipsum dolor sit amet t-bone corned beef brisket, chicken rump jerky meatloaf venison andouille ground round pig beef shankle pork. Pork loin tenderloin flank, swine rump chicken sausage leberkas pig biltong pancetta tongue tail bresaola. Biltong pastrami jerky, capicola brisket sausage ribeye drumstick shoulder leberkas beef sirloin. Strip steak fatback drumstick tri-tip corned beef bresaola.</p>
								
								<footer>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-thumbs-up"></span> helpful</a>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-thumbs-down"></span> unhelpful</a>
									<a href="" class="btn btn-xs"><span class="glyphicon glyphicon-pencil"></span> comment</a>
									<a href="" class="report"><span class="glyphicon glyphicon-ban-circle"></span></a>
								</footer>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="content review-author">
								<div class="top-contrib">Top contributor</div>
								<p><a href="user-profile.html">SFShopper</a></p>
								<small>June 30th, 2013</small>	
								<p>An avid shopper, love buying my stuff from Shopfrog. <a href="user-profile.html">Read all my reviews →</a></p>
							</div>
						</div>
					</div>
				</div> -->										
					
			</div> <!-- //end span12 -->
		</div> <!-- //end row -->		
		
		<div class="row">
			<div class="col-xs-12">
				<div class="content clearfix">
					<h3>Related products</h3>
					
					<div class="product medium">
						<div class="media">
							<a class="current" href="product.html" title="product title">
								<img src="img/product-1.jpg" alt="product title" data-img="product-1" class="img-responsive">
							</a>
							<span class="plabel">just in</span>				
						</div>
						<div class="details">
							<p class="name"><a class="current" href="product.html">BeachSide Frog</a></p>
							<p class="price"><span class="cur">$</span><span class="total">20.00</span></p>
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
					<div class="product medium">
						<div class="media">
							<a class="current" href="product.html" title="product title">
								<img src="img/product-2.jpg" alt="product title" data-img="product-2" class="img-responsive">
							</a>
						</div>
						<div class="details">
							<p class="name"><a class="current" href="product.html">BeachSide Frog</a></p>
							<p class="price"><span class="cur">$</span><span class="total">20.00</span></p>
							<a href="" class="details-expand" data-target="details-0002">+</a>
						</div>
						<div class="details-extra" id="details-0002">
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
					<div class="product medium">
						<div class="media">
							<a class="current" href="product.html" title="product title">
								<img src="img/product-1.jpg" alt="product title" data-img="product-1" class="img-responsive">
							</a>
						</div>
						<div class="details">
							<p class="name"><a class="current" href="product.html">BeachSide Frog</a></p>
							<p class="price"><span class="cur">$</span><span class="total">20.00</span></p>
							<a href="" class="details-expand" data-target="details-0003">+</a>
						</div>
						<div class="details-extra" id="details-0003">
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
					<div class="product medium">
						<div class="media">
							<a class="current" href="product.html" title="product title">
								<img src="img/product-2.jpg" alt="product title" data-img="product-2" class="img-responsive">
							</a>
						</div>
						<div class="details">
							<p class="name"><a class="current" href="product.html">BeachSide Frog</a></p>
							<p class="price"><span class="cur">$</span><span class="total">20.00</span></p>
							<a href="" class="details-expand" data-target="details-0004">+</a>
						</div>
						<div class="details-extra" id="details-0004">
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

					
				</div>
			</div> <!-- //end span12 -->
		</div> <!-- //end row -->		
		
	</div>