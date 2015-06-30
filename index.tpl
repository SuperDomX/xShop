{if $masterKey.is.admin} 
<div class="row">           
   {include file='~widgets/col.tpl' col=12 method="jumbotron"}
   {* include file='~widgets/col.tpl' method="settings" col=6 title="<i class='fa fa-gear'></i> Settings" *}
   
    {$w_col="col-md-3 col-sm-3 col-xs-6"}

    {include file='./widget.stat.tpl' w_title="Store Value" w_icon="fa-money" w_stat=$shop_sum}
    {include file='./widget.stat.tpl' w_title="Items in Stock" w_icon="fa-shopping-cart" w_stat=$items_in_stock}
    {include file='./widget.stat.tpl' w_title="Items Sold" w_icon="fa-truck" w_stat=$items_sold}
    {include file='./widget.stat.tpl' w_title="Total Sold" w_icon="fa-dollar" w_stat=$shop_sold}
    
    
    
    
    
  

 
   {* include file='~widgets/col.tpl' method="topX" col=6 title="<i class='fa fa-check'></i> Checklist" *}
</div>
{/if}