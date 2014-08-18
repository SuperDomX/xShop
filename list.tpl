<script type="text/javascript">
	
	$(document).ready(function() {
	    $('#example').dataTable( {
	        "processing": true,
	        "serverSide": true,
	        "ajax": "/{$toBackDoor}/{$Xtra}/{$method}/.json"
	    } );
	} );

</script>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Extn.</th>
                <th>Start date</th>
                <th>Salary</th>
            </tr>
        </thead>
 
        <tfoot>
            <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Extn.</th>
                <th>Start date</th>
                <th>Salary</th>
            </tr>
        </tfoot>
    </table>