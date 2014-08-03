<div class="jumbotron">
    <div class="container">
         <h1> 
         <i class="fa fa-shopping-cart fa-2x pull-right fa-border"></i> 
           {$LANG.XSHOP.JUMBO.HEAD}
        </h1>
        <p class="lead"> 
            <p> 
                
                <blockquote>
                    {$LANG.XSHOP.JUMBO.QUOTE}
                </blockquote>
            </p> 
        <p>
        {foreach $LANG.XSHOP.JUMBO.BTN as $b => $btn}
            <a class="btn btn-lg {$btn.class}" href="/{$toBackDoor}/{$Xtra}/{$b}">
                {$btn.a}
            </a>
        {/foreach}
        </p>
    </div>
</div> 
<script type="text/javascript" src="/x/html/layout/watchtower/js/grid-live.js"> </script>