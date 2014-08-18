  <div class="col-md-12">
        <section class="widget">
            <div class="body no-margin">
                <div class="row">
                    <div class="col-sm-6 col-print-6">
                        {if $atBackDoor}
	                        <h1>Order {$order.id}</h1>
	                        <a href="/{$Xtra}/orders"> Return to Orders</a>
                        {else}
	                        <h1>Order Successful</h1>
	                        <a href="/{$Xtra}/bazaar"> Return to Shop</a>
                        {/if}
                    </div>
                    <div class="col-sm-6 col-print-6">
                        <div class="invoice-number text-align-right">
                            
                            {$order.timestamp|date_format:'D, M j Y, h:ia'}
                            
                        </div>
                        <div class="invoice-number-info text-align-right">
                          Invoice #{$order.timestamp|date_format:'ymd'}O{$order.id}
                        </div>
                    </div>
                </div>
                <hr>
                <!-- <section class="invoice-info widget">
                    <div class="row">
                        <div class="col-sm-6 col-print-6">
                            <h4 class="details-title">Company Information</h4>
                            <h3 class="company-name">
                                {$site_name}
                            </h3>
                            <address>
                                <strong>{$shop_address}</strong><br>
                                {$shop_city}, {$shop_state} {$shop_postal}<br>
                                <br>
                                <abbr title="Work email">e-mail:</abbr> <a href="mailto:#">{$shop_email}</a><br>
                                <abbr title="Work Phone">phone:</abbr> {$shop_phone}<br>
                                
                                {if $shop_fax}<abbr title="Work Fax">fax:</abbr> {$shop_fax}
                                {/if}
                            </address>
                        </div>
                        <div class="col-sm-6 col-print-6 client-details">
                            <h4 class="details-title">Client Information</h4>
                            <h3 class="client-name"> 
                            </h3>
                            <address>
                                 
                                <abbr title="Work email">e-mail:</abbr> <a href="mailto:#">{$customer.email}</a><br>
                                <abbr title="Work Phone">phone:</abbr> {$customer.phone}<br>
                                <abbr title="Work Fax">fax:</abbr> {$customer.fax}
                                <div class="separator line"></div>
                                <p class="margin-none"><strong>Note:</strong><br> </p>
                            </address>
                        </div>
                    </div>
                </section> -->
                <table class="table table-bordered widget">
                    <thead>
                    <tr>
                        <th class="col-md-1">#</th>
                        <th class="col-md-3">Item</th>
                        <th class="hidden-xs col-md-3">Description</th>
                        <th class="col-md-1">Quantity</th>
                        <th  align="center" class="hidden-xs col-md-2">Price per Unit</th>
                        <th  align="right" class="col-md-2">Total</th>
                    </tr>
                    </thead> 
                    <tbody>

                    {$cents = 0}
                    {foreach $data as $row => $item}
                    	<tr>
	                        <td>{$item.sku}</td>
	                        <td>{$item.name}</td>
	                        <td class="hidden-xs">{$item.tags}</td>
	                        <td>{$item.quantity}</td>
	                        <td  align="center" class="hidden-xs">{$item.price}</td>
	                        {$c = $item.cents / 100}
	                        <td align="right">${$c|number_format:2:'.':','}</td>
	                        <!-- {$cents = $cents + $item.cents} -->
	                    </tr>
                    {/foreach}
                     
                    </tbody>
                </table>
                <div class="row">
                    <div class="col-sm-6 col-print-6">
                        <blockquote class="blockquote-sm">
                            <!-- <strong>Note:</strong> Keep in mind, sometimes bad things happen. But it's just sometimes. -->
                        </blockquote>
                    </div>
                    <div class="col-sm-6 col-print-6">
                        <div class="row text-align-right">
                            <div class="col-xs-6"></div> <!-- instead of offset -->
                            <div class="col-xs-3">
                                <!-- <p>Subtotal</p> -->
                                <!-- <p>Tax(10%)</p> -->
                                <p class="no-margin"><strong>Total</strong></p>
                            </div>
                            <div class="col-xs-3">
                                {$total = $cents / 100.00}
                                <!-- <p>${$total}</p> -->
                                <!-- <p>159.89</p> -->
                                <p class="no-margin"><strong>${$total|number_format:2:'.':','}</strong></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="invoice-actions text-align-right hidden-print">
                    <button id="print" class="btn btn-primary btn-lg ">
                       <i class="fa fa-print fa-2x pull-right"></i>
                       Print
                    </button>
                    <!-- <button class="btn btn-danger">
                        <i class="fa fa-arrow-right"></i>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        Proceed with Payment
                    </button> -->
                </div>
            </div>
        </section>
    </div>
<!-- page-specific -->
<script type="text/javascript" src="/x/html/layout/watchtower/js/print.js"></script>