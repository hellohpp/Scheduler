<?php	
	require_once("config.php");
	require_once("logHandler.php");
	require_once("dataAccess.php");
	
	class DataTier {
	
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
	}	// End class DataAccess
?>