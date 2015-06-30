<div class="jumbotron">
    <div class="container">
            <h1>
                <i class="fa fa-shopping-cart fa-4x pull-left"></i>
                {$LANG.XSHOP.JUMBO.HEAD}
            </h1>
        <p>

            {$LANG.XSHOP.JUMBO.QUOTE}
        </p>
        {foreach $LANG.XSHOP.JUMBO.BTN as $b => $btn}
        <a class="btn btn-lg {$btn.class}" href="/{$toBackDoor}/{$Xtra}/{$b}">
            {$btn.a}
        </a>
        {/foreach} 
    </div>
</div>  