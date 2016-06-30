<?php	
	require_once("data.php");
	
	class BusinessTier{
		function ValidateUser($username, $password, $errorMsg){	
		
			$dt = new DataTier;
			$results = $dt->Sel_Credentials($username);
			
			if( $results["id"] == 0 )
				if(empty($results["message"][0]) || $results["message"][0]["Password"] != $password)
					return array( "id" => 1, "message" => $errorMsg );
				else					
					return array( "id" => 0, "message" => "" );
			else
				return array( "id" => $results["id"], "message" => $results["message"] );
		}	// End function ValidateUser			
	}	// End class BusinessTier
?>