{if $masterKey.is.admin}
<div class="row">
    <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="box">
            <div class="icon">
               <strong>{$items_in_stock}</strong>  <i class="fa fa-shopping-cart"></i>
            </div>
            <div class="description">
                <strong>{$items_in_stock}</strong> Items in stock
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="box">
            <div class="big-text">
               <strong>{$items_sold}</strong> <i class="fa fa-truck fa-flip-horizontal"></i> 
                
            </div> 
            <div class="description"> 
                <strong>{$items_sold}</strong> Items Sold
            </div>
        </div>
    </div>
    <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="box">
            <div class="icon">
                <i class="fa fa-dollar"></i>  <strong>{$shop_sum}</strong>
            </div>
            <div class="description">
                <strong>${$shop_sum}</strong> Store Value
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="box">
            <div class="big-text"> 
                <strong>${$shop_sold}</strong> <i class="fa fa-money"></i>
            </div>
            <div class="description">
                <strong>${$shop_sold}</strong> Total Sold
            </div>
        </div>
    </div>
   <!--  <div class="col-md-2 col-sm-4 col-xs-6">
        <div class="box">
            <div class="icon">
                <i class="fa fa-shopping-cart"></i>
            </div>
            <div class="description">
                <strong>410</strong> orders
            </div>
        </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-6">
        <div class="box">
            <div class="big-text">
                6.42%
            </div>
            <div class="description">
                <i class="fa fa-arrow-right"></i>
                Traffic Growth
            </div>
        </div>
    </div> -->
</div>
<div class="row">           
   {include file='~widgets/col.tpl' col=9 method="jumbotron"}
   {include file='~widgets/col.tpl' method="topX" col=3 title="<i class='fa fa-check'></i> Checklist"}
   {include file='~widgets/col.tpl' method="settings" col=3 title="<i class='fa fa-gear'></i> Settings"}
</div>
{/if}