<?php	
	require_once("config.php");
	
	class LogHandler{
		
		function DebugToConsole( $data ) {
			if ( is_array( $data ) )
				$output = "<script>console.log( 'Debug Objects: " . implode( ',', $data) . "' );</script>";
			else
				$output = "<script>console.log( 'Debug Objects: " . $data . "' );</script>";

			echo $output;
		}	// End function DebugToConsole
		
		function GetMessage($id){			
			switch ($id) {
				case 1:
					return "Failed to connect to database.";
				case 2:
					return "Failed to execute query.";
				case 3:
					return "Successfully saved to database.";
				case 4:
					return "Failed to execute SQL statement.";
				case 5:
					return "Please contact the System Administrator.";
				case 6:
					return "System page not present in Pages table in database.";				
				default:
					return "Unknown message";
					break;
			}	// End switch		
		}	// End function GetMessage
		
		function WriteToLog($userMessageNum, $systemMsg){	
			$fileStream = fopen( LOGFILE, LOGWRITEMETHOD );

			$msg = date("Y-m-d H:i:s") . " - " . $systemMsg . " : " . $this->GetMessage($userMessageNum) . PHP_EOL;
			fwrite( $fileStream, $msg );
			fclose( $fileStream );
			return  array( "id" => $userMessageNum, "message" => $this->GetMessage($userMessageNum) );
		}	// End function WriteToLog				

	}	// End class Messages
?>