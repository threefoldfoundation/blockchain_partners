<?php include("header.php");?>
      <!-- End Navigation Bar-->
      <div class="wrapper">
         <div class="container">
            <!-- Page-Title -->
            <div class="row">
               <div class="col-sm-12">
                  <div class="page-title-box">
                     <div class="btn-group pull-right">
                    
                     </div>
                     <h4 class="page-title ">
                        <img class="icon-colored ml-0" src="assets/images/pre-logo.png" title="presearch-pre-logo.svg" alt="colored-icons">
                        Presearch Node Status
                     </h4>
                     <p>Your Presearch node is now running succesfully on the ThreeFold Grid. You could also verify the status of the node by visiting<a href="https://nodes.presearch.org/dashboard"> https://nodes.presearch.org/dashboard</a></p>
		     <p>NOTE : Please ensure to have the correct registration code. In case the code is wrong, the node would not register.</p>
	  
	 
		 <div class="row">
         	<div class="col-lg-12 col-md-12 col-sm-12">
         		 <button class="btn btn-custom waves-light waves-effect w-md m-b-5 pull-right" onclick="window.location.reload();">Refresh</button>
         	</div>
         </div>
		 
		<div class="row">
		    <div class="col-lg-12 col-md-4 col-sm-6">
                <div class="card-boxbg col-md-12" style="background-color: blue;color: white;">
                    <div class="col-md-14">
                        <p>Node Registration Code  :  <?php if ( file_exists("/tmp/checkcode") ){ $RegistrationCodeFile = new SplFileObject("/tmp/checkcode");
 $RegistrationCode= trim($RegistrationCodeFile->fgets());if(!empty($RegistrationCode)) echo  $RegistrationCode; else echo "Not Available";
				}?> </p>
                    </div>
                </div>
            </div>
        </div>
			   
			   
        <div class="row">
            <div class="col-lg-12 col-md-4 col-sm-6">
                <div class="card-boxbg col-md-12" style="background-color: #E8F5FF;color: black;">
		            <div class="col-md-14">
 			
					<p>NOTE : On ThreeFold's VDC, your blockchain node runs as a Kubernetes pod. Since you have access to your Kubernetes cluster, you can still connect to your node over bash.</p>			
					<p>export KUBECONFIG=/path/to/your/kubeconfig/file</p>
					<p>kubectl get pods</p>
					<p>kubectl exec -it presearch_pod_name -- bash</p>
			                   
                    </div>
                </div>
            </div>
        </div>
	</div>

     	<div class="row">
            <div class="col-lg-12 col-md-4 col-sm-6">  
                <div class="card-box col-md-12">
                    <div class="col-md-12">
                    <span id="PresearchServiceP2P"></span>
                        
                    </div>
                </div>
            </div>   
        </div>          
                  
				  
		<div class="row">	
			<div class="col-lg-12 col-md-4 col-sm-6"> 
				<div class="card-box col-md-12">
                    <div class="col-md-10">
                        <h4>Presearch Node Log 
                           <img class="icon-flat" src="assets/images/icons/checkmark.svg" title="checkmark.svg" alt="colored-icons">
                        </h4>
                        <p>The node log of the last 100 lines is shown below. However, if you want to see the full log, you can download the complete log file by clicking the save button. The log file may populate in a few minutes.</p>
                    </div>
                    <div class="col-md-2 m-t-2">
                        <button class="btn btn-success pull-right" ><a href="node.log" download style="color:#fff;">Save Log</a></button>
                    </div>
                </div>
            </div>
		</div>
		<div class="row">
		<div class="col-lg-12">
               <div class="portlet">
                  <div class="portlet-heading portlet-default">
                     
                     <div class="portlet-widgets">
                        <a href="javascript:;" data-toggle="reload"><i class="ion-refresh"></i></a>
                        <span class="divider"></span>
                        <a data-toggle="collapse" data-parent="#accordion1" href="#bg-default"><i class="ion-minus-round"></i></a>
                        <span class="divider"></span>
                        <a href="#" data-toggle="remove"><i class="ion-close-round"></i></a>
                     </div>
                     <div class="clearfix"></div>
                  </div>
                  <div id="bg-default" class="panel-collapse collapse in" >
                  <div class="card-box">
                     <div class="slimScrollDiv  portlet-body pl-10em bg-dark" style="position: relative; overflow-y: scroll; width: auto; height: 350px !important;">
                        <?php // use it by
                         if ( file_exists("/tmp/checklogs") )
				{
                        $fh = fopen('/tmp/checklogs','r');
	while ($value = fgets($fh)) {
		echo  $value."<br>";
	}
				
	fclose($fh);
				} // end file if exist
?>
                     </div>
                     </div> <!-- end card-box -->
                  </div>
               </div>
            </div>
		</div><!-- end row -->
		
		
	</div>
				
      		     
            <!-- End row -->
            <?php include("footer.php");?>
<script type="text/javascript" src= "https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script id="verificationRPC" language="javascript" type="text/javascript">

function CheckPresearchServiceP2P() {
    $.ajax({
        url: 'PresearchService.php', //php          
      //  data: "", //the data "caller=name1&&callee=name2"
      //  dataType: 'json', //data format   
        success: function (data) {
            //on receive of reply
           // alert(data);
            //var foobar = data[2]; //foobar
            $('#PresearchServiceP2P').html(data); //output to html
        }
    });
}

$(document).ready(CheckPresearchServiceP2P); // Call on page load
setInterval(CheckPresearchServiceP2P, 120000); //every 120 secs
//                
</script>
