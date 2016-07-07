<?php	
	require_once("data.php");
	
	class BusinessTier{
		
		function ResetPassword($password, $sessionData, $errorMsg){	
		
			$dt = new DataTier;
			$results = $dt->Upd_ResetPassword($sessionData->username, $password);
			$i = 0;
			
			if( $results["id"] == 0 )							
				$dt->Ins_SessionEvent($sessionData);
				return array( "id" => 0, "message" => "" );
			else
				return array( "id" => $results["id"], "message" => $results["message"] );
		}	// End function ResetPassword
		
		function ValidateAnswers($questions, $sessionData, $errorMsg){	
		
			$dt = new DataTier;
			$results = $dt->Sel_ResetQuestions($sessionData->userName);
			$i = 0;
			
			if( $results["id"] == 0 )
				if(empty($results["message"][0]))
					return array( "id" => 1, "message" => $errorMsg );
				else {	
					foreach($results["message"] as $result){
						if(strtolower($result["Answer"]) != strtolower($questions[$i]->answer)){
							return array( "id" => 1, "message" => $errorMsg );
						}
						$i++;
					}														
					$dt->Ins_SessionEvent($sessionData);
					return array( "id" => 0, "message" => $results["message"][0]["EventId"] );
				}
			else
				return array( "id" => $results["id"], "message" => $results["message"] );
		}	// End function ValidateResetAnswers
		
		function GetResetQuestions($sessionData, $errorMsg){	
		
			$dt = new DataTier;
			$results = $dt->Sel_ResetQuestions($sessionData->userName);
			
			if( $results["id"] == 0 )
				if(empty($results["message"][0]))
					return array( "id" => 1, "message" => $errorMsg );
				else {		
					$questions = array();
					foreach($results["message"] as $result){
						array_push($questions, $result["Question"]);
					}									
					$dt->Ins_SessionEvent($sessionData);
					return array( "id" => 0, "message" => $questions );
				}
			else
				return array( "id" => $results["id"], "message" => $results["message"] );
		}	// End function GetResetQuestions
		
		function ValidateUser($password, $sessionData, $errorMsg){	
		
			$dt = new DataTier;
			$results = $dt->Sel_Credentials($sessionData->userName);
			
			if( $results["id"] == 0 )
				if(empty($results["message"][0]) || $results["message"][0]["Password"] != $password)
					return array( "id" => 1, "message" => $errorMsg );
				else{					
					$dt->Ins_SessionEvent($sessionData);
					return array( "id" => 0, "message" => $results["message"][0]["EventId"]);
				}
			else
				return array( "id" => $results["id"], "message" => $results["message"] );
		}	// End function ValidateUser
	}	// End class BusinessTier
?>