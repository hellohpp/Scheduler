<?php	
	class DataAccess{
	
		function GetSproc($sprocNum){
			switch($sprocNum){
				case "sel_Credentials":
					return "SELECT Id, Password, UserId, IsActive FROM `otsys`.`credentials` WHERE UserName = ?;";
				default:
					break;
			}	// End switch
		}	// End function GetSproc		
	}	// End class DataAccess
?>