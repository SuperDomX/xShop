{include file="~widgets/billboard.tpl"}
<section class="widget">
    <form id="fileupload" action="server/php" method="POST" enctype="multipart/form-data">

    <div class="row">
        <div class="col-md-12 fileupload-progress fade">
            <!-- The global progress bar -->
            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                <div class="bar" style="width:0%;"></div>
            </div>
            <!-- The extended global progress information -->
            <div class="progress-extended">&nbsp;</div>
        </div>
    </div>
   
    <div class="fileupload-loading"><i class="fa fa-spin fa-spinner"></i></div>
    <div class="row">
        <div class=" col-md-3">
            <div class="form-actions fileupload-buttonbar no-margin">
                <span class="fileinput-button btn btn-info  btn-block">
                        <i class="fa fa-plus"></i>
                        <span>Add files...</span>
                        <input type="file" name="files[]" multiple="">
                    </span>
                <button type="submit" class="btn btn-success  btn-block start">
                    <i class="fa fa-upload"></i>
                    <span>Start upload</span>
                </button>
                <button type="reset" class="btn btn-warning  btn-block cancel">
                    <i class="fa fa-ban"></i>
                    <span>Cancel upload</span>
                </button>
            </div>
        </div>
        <div class="col-md-9">
            <div id="dropzone"  class="dropzone">
                Drop Item Pics Here
                <i class="fa fa-download-alt pull-right"></i>
            </div>
        </div>
        
    </div>
    <!-- The table listing the files available for upload/download -->
    <table role="presentation" class="table table-striped"><tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody></table>
</form>
 
<!-- jquery plugins -->
<!-- <script type="text/javascript" src="{$WT}lib/jquery-maskedinput/jquery.maskedinput.js"></script>
<script type="text/javascript" src="{$WT}lib/parsley/parsley.js"> </script>
<script type="text/javascript" src="{$WT}lib/icheck.js/jquery.icheck.js"></script>
<script type="text/javascript" src="{$WT}lib/select2.js"></script>
 -->

<!-- basic application js-->
<!-- <script type="text/javascript" src="js/app.js"></script>
<script type="text/javascript" src="js/settings.js"></script> -->

<!-- page specific -->
<script type="text/javascript"> 
    $(function () {
        function pageLoad(){
            'use strict';

            var url = '/{$toBackDoor}/{$Xtra}/{$method}/true'

            // Initialize the jQuery File Upload widget:
            var $fileupload = $('#fileupload');
            $fileupload.fileupload({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: { withCredentials: true },
                url      : url,
                dropZone : $('#dropzone')
            });

            // Enable iframe cross-domain access via redirect option:
            // $fileupload.fileupload(
            //     'option',
            //     'redirect',
            //     window.location.href.replace(
            //         /\/[^\/]*$/,
            //         '/cors/result.html?%s'
            //     )
            // );

            $('.template-download').remove();

            $.ajax({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: { withCredentials: true},
                url      : url,
                dataType : 'json',
                context  : $fileupload[0]
            }).done(function (result) {
                $(this).fileupload('option', 'done')
                    .call(this, null, { result: result });
            });
 

            
        }

        pageLoad();

        PjaxApp.onPageLoad(pageLoad);

    });

</script>
{literal}
<script id="template-upload" type="text/template">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td class="preview"><span class="fade"></span></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
        <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
        <td>
            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                <div class="bar" style="width:0%;"></div>
            </div>
        </td>
        <td>{% if (!o.options.autoUpload) { %}
            <button class="btn btn-primary  start">
                <i class="fa fa-upload"></i>
                <span>Start</span>
            </button>
            {% } %}</td>
        {% } else { %}
        <td colspan="2"></td>
        {% } %}
        <td>{% if (!i) { %}
            <button class="btn btn-warning   cancel">
                <i class="fa fa-ban"></i>
                <span>Cancel</span>
            </button>
            {% } %}</td>
    </tr>
    {% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/template">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
        <td></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else { %}
        <td class="preview">{% if (file.thumbnailUrl) { %}
            <a href="{%=file.url%}" title="{%=file.name%}" data-gallery="gallery" download="{%=file.name%}"><img src="{%=file.thumbnailUrl%}"></a>
            {% } %}</td>
        <td class="name">
            <a href="{%=file.url%}" title="{%=file.name%}" data-gallery="{%=file.thumbnailUrl&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
        </td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td colspan="2"></td>
        {% } %}
        <td>
            <button class="btn btn-danger  delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.delete_with_credentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
            <i class="fa fa-trash-o"></i>
            <span>Delete</span>
            </button>
        </td>
    </tr>
    {% } %}
</script>
 
{/literal}
</section>