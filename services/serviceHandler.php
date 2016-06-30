<?php
	require_once("../data/business.php");
	require_once("../data/logHandler.php");
	
	// Global variables
	$result = array();
	$bt = new BusinessTier;
	$log = new LogHandler;
	
	$postdata = file_get_contents("php://input");
	$request = json_decode($postdata);
	switch ($_SERVER['REQUEST_METHOD']) {
	
		// Save a new record in the database
		case 'POST':			
//			$result = $bt->ValidateUser(trim( $_POST["userName"]), trim($_POST["userPass"]), trim($_POST["errorMsg"]) );
			switch( $request->functionName ){
				case "login":
					$result = $bt->ValidateUser(trim($request->userName), trim($request->userPass), trim($request->errorMsg) );
					break;
				default:
					$result = $log->WriteToLog( 5, "Angular.js function is unknown" );
					break;
			}
			break;
		default:	
			$result = $log->WriteToLog( 5, "Angular.js request method is unknown" );
			break;
	}	// End switch

	$json = json_encode($result);
	echo $json;

?>