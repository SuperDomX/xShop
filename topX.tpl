<div class="list-group">
    {if $data.import != 0}
        <a href="/{$toBackDoor}/{$Xtra}/import" class="list-group-item">
            <i class="fa fa-chevron-right pull-right"></i>
            <span class="badge badge-danger">{$topX.import}</span>
            <i class="fa fa-lg fa-camera-retro"></i>&nbsp;
            Images to Import
        </a>
    {/if}

    <a href="/{$toBackDoor}/{$Xtra}/orders" class="list-group-item">
        <i class="fa fa-chevron-right pull-right"></i>
        <span class="badge badge-success">{$data.orders|count}</span>
        <i class="fa fa-lg fa-truck"></i>&nbsp;
        Orders
    </a>
    <a href="/{$toBackDoor}/{$Xtra}/stock" class="list-group-item">
        <i class="fa fa-chevron-right pull-right"></i>
        <span class="badge badge-danger">{$data.out_of_stock|count}</span>
        <span class="fa-stack fa-lg">
          <i class="fa fa-shopping-cart fa-stack-1x"></i>
          <i class="fa fa-ban fa-stack-2x text-danger"></i>
        </span>
        Out-of-Stock
    </a>
    <!-- <a href="/{$toBackDoor}/{$Xtra}/followup" class="list-group-item">
        <i class="fa fa-chevron-right pull-right"></i>
        <span class="badge badge-default">{$data.out_of_stock|count}</span>
        <i class="fa fa-lg fa-phone"></i>&nbsp;
        Follow Up Calls
    </a>
    <a href="/{$toBackDoor}/{$Xtra}/carts/abandoned" class="list-group-item">
        <i class="fa fa-chevron-right pull-right"></i>
        <span class="badge badge-info">{$data.out_of_stock|count}</span>
        <i class="fa fa-lg fa-bell"></i>&nbsp;
        Abandoned Carts
    </a>
    <a href="/{$toBackDoor}/{$Xtra}/suggestions" class="list-group-item">
        <i class="fa fa-chevron-right pull-right"></i>
        <span class="badge badge-warning">{$data.out_of_stock|count}</span>
        <i class="fa fa-lg fa-comments"></i>&nbsp;
        Suggestion Box
    </a> -->
</div>