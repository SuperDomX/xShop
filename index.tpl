{if $masterKey.is.admin} 
<div class="row">           
   {include file='~widgets/col.tpl' col=12 method="jumbotron"}
   {* include file='~widgets/col.tpl' method="settings" col=6 title="<i class='fa fa-gear'></i> Settings" *}
    <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="widget">
            <h1> 
                <strong>${$shop_sold}</strong> <i class="fa fa-money"></i>
            </h1>
            <div class="description">
                <strong>${$shop_sold}</strong> Total Sold
            </div>
        </div>
    </div>

    <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="widget">
            <h1 class="icon">
                <i class="fa fa-dollar"></i>  <strong>{$shop_sum}</strong>
            </h1>
            <div class="description">
                <strong>${$shop_sum}</strong> Store Value
            </div>
        </div>
    </div>
  
    <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="widget">
            <h1 class="big-text">
               <strong>{$items_sold}</strong> <i class="fa fa-truck fa-flip-horizontal"></i> 
                
            </h1> 
            <div class="description"> 
                <strong>{$items_sold}</strong> Items Sold
            </div>
        </div>
    </div>
     <div class="col-md-3 col-sm-4 col-xs-6">
        <div class="widget">
            <h1 class="icon">
               <strong>{$items_in_stock}</strong>  <i class="fa fa-shopping-cart"></i>
            </h1>
            <div class="description">
                <strong>{$items_in_stock}</strong> Items in stock
            </div>
        </div>
    </div>

   {* include file='~widgets/col.tpl' method="topX" col=6 title="<i class='fa fa-check'></i> Checklist" *}
</div>
{/if}