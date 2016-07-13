<?php	
	require_once("config.php");
	require_once("logHandler.php");
	require_once("dataAccess.php");
	
	class DataTier {		
		
		function Upd_ResetPassword($username, $password){
			$log = new LogHandler();
			
			if ( $this->ValidateConnection( $con = $this->OpenConnection( ) ) == true ) {				
				$da = new DataAccess();
				$query = $da->GetSproc("upd_ResetPassword");
				
				if( $stmt = $con->prepare( $query ) ){
					$stmt->bind_param( "ss", $password, $username ); 
					$result = $stmt->execute();
					$this->CloseDBConnection( $con );
					
					if ( $result === true ) {
						return array( "id" => 0, "message" => array() );
					} else {						
						$log->WriteToLog( 4, "Upd_ResetPassword function failed to update event in the database" );
						return array( "id" => 1, "message" => array() );
					}
				} 	// End if
			} else {
				return $log->WriteToLog( 1, "Upd_ResetPassword function failed to connect to database" );
			} 	// End if	
		}	// End method Upd_ResetPassword
		
		function Sel_ResetQuestions($username){
			$log = new LogHandler();
			
			if ( $this->ValidateConnection( $con = $this->OpenConnection( ) ) == true ) {				
				$da = new DataAccess();
				$query = $da->GetSproc("sel_ResetQuestions");
				
				if( $stmt = $con->prepare( $query ) ){
					$stmt->bind_param( "s", $username ); 
					$stmt->execute();
					
					$results = $stmt->get_result();
					if( $results->num_rows > 0 ){						
						$resultArray = array();
						while ($row = $results->fetch_assoc()){
							$resultArray []= $row;
						}						
						$stmt->close( );
						$this->CloseDBConnection( $con );
						return array( "id" => 0, "message" => $resultArray );
					} else {						
						return array( "id" => 0, "message" => array() );
					}	// End if/else
				} 	// End if
			} else {
				return $log->WriteToLog( 1, "Sel_ResetQuestions function failed to connect to database" );
			} 	// End if	
		}	// End method Sel_ResetQuestions
		
		function Sel_Credentials($username){
			$log = new LogHandler();
			
			if ( $this->ValidateConnection( $con = $this->OpenConnection( ) ) == true ) {				
				$da = new DataAccess();
				$query = $da->GetSproc("sel_Credentials");
				
				if( $stmt = $con->prepare( $query ) ){
					$stmt->bind_param( "s", $username ); 
					$stmt->execute();
					
					$results = $stmt->get_result();
					if( $results->num_rows > 0 ){						
						$resultArray = array();
						while ($row = $results->fetch_assoc()){
							$resultArray []= $row;
						}						
						$stmt->close( );
						$this->CloseDBConnection( $con );
						return array( "id" => 0, "message" => $resultArray );
					} else {						
						return array( "id" => 0, "message" => array() );
					}	// End if/else
				} 	// End if
			} else {
				return $log->WriteToLog( 1, "Sel_Credentials function failed to connect to database" );
			} 	// End if	
		}	// End method Sel_Credentials
		
		function Ins_SessionEvent($sessionData){
			$log = new LogHandler();
			
			if ( $this->ValidateConnection( $con = $this->OpenConnection( ) ) == true ) {				
				$da = new DataAccess();
				$query = $da->GetSproc("ins_SessionEvent");
				
				if( $stmt = $con->prepare( $query ) ){
					$stmt->bind_param( "ssss", $sessionData->userId, $sessionData->pageName, $sessionData->eventName, $sessionData->userId ); 
					$result = $stmt->execute();
					$this->CloseDBConnection( $con );
					
					if ( $result === true ) {
						return array( "id" => 0, "message" => array() );
					} else {						
						$log->WriteToLog( 4, "Ins_SessionEvent function failed to insert event into database" );
						return array( "id" => 1, "message" => array());
					}
				} 	// End if
			} else {
				return $log->WriteToLog( 1, "Ins_SessionEvent function failed to connect to database" );
			} 	// End if	
		}	// End method Ins_SessionEvent
	
		function OpenConnection(){
				
			return mysqli_connect(DBENVIRONMENT, DBUSER, DBPASS, DBNAME);
			
		}	// End function GetConnection
				
		// Check connection
		function ValidateConnection( $con ){
			
			if ( mysqli_connect_errno( $con ) ) 
				return false;
			
			return true;
			
		}	// End function ValidateConnection

		function CloseDBConnection($con){

			mysqli_close( $con );
			
		}	// End function CloseDBConnection		
	}	// End class DataAccess
?>