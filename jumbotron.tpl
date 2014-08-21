<div class="jumbotron">
    <div class="container">
        
        <h1>
            {$LANG.XSHOP.JUMBO.HEAD}
        </h1>
            <h4><i class="fa fa-shopping-cart fa-5x pull-right fa-border"></i></h4>
        <blockquote>

            {$LANG.XSHOP.JUMBO.QUOTE}
        </blockquote>
        {foreach $LANG.XSHOP.JUMBO.BTN as $b => $btn}
        <a class="btn btn-lg {$btn.class}" href="/{$toBackDoor}/{$Xtra}/{$b}">
            {$btn.a}
        </a>
        {/foreach} 
    </div>
</div>  