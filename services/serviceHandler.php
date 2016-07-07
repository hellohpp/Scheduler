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
			switch( $request->sessionData->eventName ){
				case "ResetPassword":
					$result = $bt->ResetPassword(trim($request->resetPassword), $request->sessionData, trim($request->errorMsg));
					break;
				case "ValidateAnswers":
					$result = $bt->ValidateAnswers($request->questions, $request->sessionData, trim($request->errorMsg));
					break;
				case "ResetRequest":
					$result = $bt->GetResetQuestions($request->sessionData, trim($request->errorMsg));
					break;
				case "Login":
					$result = $bt->ValidateUser(trim($request->userPass), $request->sessionData, trim($request->errorMsg));
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