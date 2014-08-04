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
                <div class="input-group">
                    <span class="input-group-btn">
                        <button class="btn btn-default active disabled" type="button">
                             Swipe Key
                        </button>
                    </span>
                    <input id="swipe_key" type="text"
                           data-trigger="change" required="required"
                           class="form-control"
                           name="nexus[swipe_key]" value="{if $swipe_key}{$swipe_key}{else}{/if}">
                    <span class="input-group-btn">
                        <button class="btn btn-success" type="button" onclick="window.updateNexusServer(this);">
                             <i class="fa fa-key"></i> Save Key
                        </button>
                    </span>
                </div>
                <script type="text/javascript">
                    window.updateNexusServer = function (t) {
                        
                        // body...
                        var t = $(t);
                        t.toggleClass('btn-success');
                        t.toggleClass('btn-danger');
                        var html = t.html();


                        t.html('<i class="fa fa-refresh fa-spin"></i> Saving...');

                        $.ajax({
                            type     : "POST",
                            url      : "/.json",
                            data     : {
                                config : {
                                    swipe_key : $('#swipe_key').val()
                                }
                            },
                            dataType : "json",
                            success: function(data)
                            {
                              // Handle the server response (display errors if necessary)
                                if(data.success)
                                    t.html(html);
                                    t.toggleClass('btn-danger');
                                    t.toggleClass('btn-success');
                            }
                        });


                    }
                </script>
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