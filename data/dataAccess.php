<?php	
	class DataAccess{
	
		function GetSproc($sprocNum){
			switch($sprocNum){
				case "upd_ResetPassword":
					return "UPDATE otsys.credentials SET `Password` = 'Wilson13' WHERE UserName = ?";
				case "ins_SessionEvent":
					return "INSERT INTO `otsys`.`user_events` (UserId, PageId, EventId, CreatedBy) SELECT ( SELECT UserId FROM otsys.credentials WHERE UserName = ? ), 
						( SELECT Id FROM otsys.pages WHERE Abbr = ? ), ( SELECT Id FROM otsys.events WHERE Abbr = ? ), ( SELECT UserId FROM otsys.credentials WHERE UserName = ? );";
				case "sel_ResetQuestions":
					return "SELECT uq.Id, uq.UserId, (SELECT q.Name FROM otsys.questions q WHERE q.Id = uq.QuestionId) AS `Question`, uq.Answer, (SELECT e.Id FROM otsys.events e WHERE e.Abbr = 'resetQuestions') AS `EventId`
						FROM otsys.user_questions uq JOIN otsys.credentials c ON uq.UserId = c.UserId WHERE c.UserName = ? ORDER BY uq.SortOrder LIMIT 2;";
				case "sel_Credentials":
					return "SELECT Id, Password, UserId, IsActive, (SELECT e.Id FROM otsys.events e WHERE e.Abbr = 'login') AS `EventId` FROM `otsys`.`credentials` WHERE UserName = ?;";
				default:
					break;
			}	// End switch
		}	// End function GetSproc		
	}	// End class DataAccess
?>