<div class="widget large map">
    <div id="location"></div>
</div>
{include file="~widgets/billboard.tpl" size=12}
<script type="text/javascript">
	window.addMarker = function(results){
        if ( !results ) return;
        $(this).gmap3({
            marker:{
                latLng:results[0].geometry.location
            },
            map:{
                options:{
                    center: results[0].geometry.location,
                    zoom: 2
                }
            }
        });
    }

    window.zoomToMarker = function(results){
        if ( !results ) return;
        $(this).gmap3({
            marker:{
                latLng:results[0].geometry.location
            },
            map:{
                options:{
                    center: results[0].geometry.location,
                    zoom: 7
                }
            }
        });
    }
</script>

<div class="row">
	{foreach $addresses as $mark => $a}
		{$id = $mark|md5|substr:0:7}
		<div class="col-md-3">
	        <section class="widget">
	            <header>
	                <h4>
	                    <i class="fa fa-map-marker"></i>
	                    {$a.primary_street_line} {$a.municipality_major}, {$a.district} {$a.postal}
	                </h4>
	                 
	            </header>
	            <div class="body">
	                <div class="map" style="height: 150px">
	                    <div id="{$id}"></div>
	                </div>
	                <div class="form-group no-margin">  
						<form action="/{$toBackDoor}/{$Xtra}/{$method}/.json" id="form-{$item.sku}" method="POST" onsubmit="return window.updateShelf(this,event);"> 
							 
							<div class="input-group input-group-lg">
								<span class="input-group-addon">
		                            <i class="fa fa-truck fa-flip-horizontal"></i>
		                        </span>
								<input type="text" class="input-sm form-control  input-transparent" value="{$item.name}" name="shipment[tracking_number]">
							</div> 

							<button class="btn btn-bottom btn-success qadd" type="submit">
								<i class="fa fa-truck"></i> Update Order
							</button>	
							<a href="/{$toBackDoor}/{$Xtra}/thanks/{$a.order_id}" class="btn btn-bottom btn-sm btn-info qadd" type="submit">
								<i class="fa fa-eye"></i> View Order
							</a>	
							<input type="hidden" value="{$item.id}" name="shelf[id]">
						</form>
					</div>
	            </div>
	            <script type="text/javascript">
		            $('#{$id}').width("100%").height("100%").gmap3({
		            	getlatlng : {
							address  :  "{$a.primary_street_line} {$a.postal}",
							callback :  window.zoomToMarker
		            	} 
		            });
	            </script>
	        </section>
	    </div> 
	{/foreach}
	 
</div>


        <script type="text/javascript">
        	
        	if(typeof(google) == 'undefined'){
        		var script = document.createElement('script');
                script.type = 'text/javascript';
                script.src = 'http://maps.google.com/maps/api/js?sensor=false&language=en&' +
                    // 'callback=mapsPageLoad';
                document.body.appendChild(script); 
        	}

	        $(document).ready(function  () {



	        	$('#location').width("100%").height("100%").gmap3({
	        		map:{
                        options : {
							navigationControl      : false,
							
							streetViewControl      : false,
							mapTypeControl         : false,
							disableDoubleClickZoom : true,
							scrollwheel            : false,
		        		}
                    }

	        	});
  				var a = 0;
			    {foreach $addresses as $key => $a}
				    a = "{$a.primary_street_line} {$a.postal}"; 
				    $("#location").gmap3({
		                getlatlng : {
							address  :  a,
							callback :  window.addMarker
		            	}
		            });

		             console.log("Marked: "+a);


	            {/foreach}
	            // PjaxApp.onPageLoad(mapsPageLoad);
	        });



	         // PjaxApp.onPageLoad(mapsPageLoad);
			   
        </script>
<!-- 
<div class="content container">
        
        <div class="row">
            <div class="col-md-6">
                <section class="widget large">
                    <header>
                        <h4>
                            <i class="fa fa-google-plus"></i>
                            Google maps. Basic
                        </h4>
                    </header>
                    <div class="body">
                        <div class="map">
                            <div id="basic"></div>
                        </div>
                    </div>
                </section>
            </div>
            <div class="col-md-6">
                
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <section class="widget large">
                    <header>
                        <h4>
                            <i class="fa fa-arrow-right"></i>
                            Region vector map
                        </h4>
                        <div class="actions">
                            <select id="part" class="selectpicker"
                                    data-style="btn-success btn-sm">
                                <option value="europe_en">Europe</option>
                                <option value="usa_en">USA</option>
                                <option value="australia_en">Australia</option>
                            </select>
                        </div>
                    </header>
                    <div class="body">
                        <div class="map">
                            <div id="vector-detailed"></div>
                        </div>
                    </div>
                </section>
            </div>
            <div class="col-md-6">
                <section class="widget large">
                    <header>
                        <h4>
                            <i class="fa fa-dashboard"></i>
                            World vector map
                        </h4>
                    </header>
                    <div class="body">
                        <div class="map">
                            <div id="vector-world"></div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Modal title</h4>
                    </div>
                    <div class="modal-body">
                        <p>One fine body…</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>


    </div>
 -->