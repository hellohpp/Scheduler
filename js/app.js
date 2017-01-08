var app = angular.module('wfd-scheduler', ['ngRoute']);

app.config(function($routeProvider, $locationProvider) {
	$routeProvider.
		when('/login', {
		   templateUrl: 'views/login.html',
		   controller: 'LoginCtrl'
		}).
		when('/reset', {
		   templateUrl: 'views/reset.html',
		   controller: 'ResetCtrl'
		}).
		when('/dashboard', {
		   templateUrl: 'views/dashboard.html',
		   controller: 'DashboardCtrl'
		}).
		when('/admin', {
		   templateUrl: 'views/admin.html',
		   controller: 'AdminCtrl'
		}).
		otherwise({
			redirectTo: '/login'
		});		
});

/***
*	Dashboard Controller
***/
app.controller('AdminCtrl', function($scope, locationHandler, userSession) {	

});// End Admin Controller

app.controller('DashboardCtrl', function($scope, $location, locationHandler, userSession) {	
	// Constant variables
	var LOWERYEARLIMIT = new Date().getFullYear() - 2;
	var UPPERYEARLIMIT = new Date().getFullYear() + 3;
	
	// Initialize local functions	
	function LoadViews(){
		var _viewNames = [ "month", "week", "day" ];
		return { availableOptions : _viewNames, selectedOption : _viewNames[0] };
	}	// End function LoadViews
	
	function LoadDays(year, month){		
		var _days = [];
		var _date = new Date(year, month + 1, 0);
		for( var _i = 1; _i <= _date.getDate(); _i++ )
			_days.push(_i);	
		
		return { availableOptions : _days, selectedOption : new Date().getDate() };	
	}	// End function LoadDays
	
	Date.prototype.getWeekOfMonth = function() {
		var month = this.getMonth()
			, year = this.getFullYear()
			, firstWeekday = new Date(year, month, 1).getDay()
			, lastDateOfMonth = new Date(year, month + 1, 0).getDate()
			, offsetDate = this.getDate() + firstWeekday - 1
			, index = 1 // start index at 0 or 1, your choice
			, weeksInMonth = index + Math.ceil((lastDateOfMonth + firstWeekday - 7) / 7)
			, week = index + Math.floor(offsetDate / 7)
		;
		return week;
	};
	
	function LoadWeeks(){
		var _weeks = [ 				
			{ id: '1', name: "Week: 1", value: 1 },
			{ id: '2', name: "Week: 2", value: 2 },
			{ id: '3', name: "Week: 3", value: 3 },
			{ id: '4', name: "Week: 4", value: 4 },
			{ id: '5', name: "Week: 5", value: 5 }
		];		
		return { availableOptions : _weeks, selectedOption : _weeks[new Date().getWeekOfMonth() - 1]};	
	}	// End function LoadWeeks

	function LoadMonths(){
		var _monthNames = [ 	
			{ id: '1', name: "January", value: 0 },
			{ id: '2', name: "February", value: 1 },
			{ id: '3', name: "March", value: 2 },
			{ id: '4', name: "April", value: 3 },
			{ id: '5', name: "May", value: 4 },
			{ id: '6', name: "June", value: 5 },
			{ id: '7', name: "July", value: 6 },
			{ id: '8', name: "August", value: 7 },
			{ id: '9', name: "September", value: 8 },
			{ id: '10', name: "October", value: 9 },
			{ id: '11', name: "November", value: 10 },
			{ id: '12', name: "December", value: 11 } 
		];
		var _monthIndex = new Date().getMonth();
		return { availableOptions : _monthNames, selectedOption : _monthNames[_monthIndex] };
	}	// End function LoadMonths
	
	function LoadYears(){
		var _years = [];
		for( var i = LOWERYEARLIMIT; i <= UPPERYEARLIMIT; i++ )
			_years.push(i);	
		
		return { availableOptions : _years, selectedOption : new Date().getFullYear() };	
	}	// End function LoadYears	
	
	Date.prototype.addDays = function(days){
		var date = new Date(this.valueOf());
		date.setDate(date.getDate() + days);
		return date;
	}
	
	function GetWeekData(){
		var _calendarData = [];
		var _weekIndex = $scope.getWeeks.selectedOption.value;
		var _monthIndex = $scope.getMonths.selectedOption.value;
		var _year = $scope.getYears.selectedOption;		
		var _firstDayofCalendar = new Date(_year, _monthIndex, 1);
		
		//What date is the first sunday of the week?	
		if(_firstDayofCalendar.getDay() > 0)
			_firstDayofCalendar.setDate(1 - _firstDayofCalendar.getDay() + (7 * ( _weekIndex - 1 )));
		else
			_firstDayofCalendar.setDate(-6  + (7 * ( _weekIndex - 1 )));		
			
		for(var _i=0; _i < 7; _i++){
			if( _monthIndex === _firstDayofCalendar.addDays(_i).getMonth() )
				if( new Date().toDateString() === _firstDayofCalendar.addDays(_i).toDateString() )
					_calendarData.push({id : _i, day : _firstDayofCalendar.addDays(_i).getDate(), isToday : true, thisMonth : true});
				else
					_calendarData.push({id : _i, day : _firstDayofCalendar.addDays(_i).getDate(), isToday : false, thisMonth : true})
			else
				_calendarData.push({id : _i, day : _firstDayofCalendar.addDays(_i).getDate(), isToday : false, thisMonth : false});
		} 
		
		return _calendarData;	
	}	// End function GetWeekData
	
	function GetMonthData(){
		var _calendarData = [];
		var _monthIndex = $scope.getMonths.selectedOption.value;
		var _year = $scope.getYears.selectedOption;		
		var _firstDayofCalendar = new Date(_year, _monthIndex, 1);
		
		//What date is the first sunday of the month?	
		if(_firstDayofCalendar.getDay() > 0)
			_firstDayofCalendar.setDate(1 - _firstDayofCalendar.getDay());
		else
			_firstDayofCalendar.setDate(-6);		
			
		for(var _i=0; _i < (7*6); _i++){
			if( _monthIndex === _firstDayofCalendar.addDays(_i).getMonth() )
				if( new Date().toDateString() === _firstDayofCalendar.addDays(_i).toDateString() )
					_calendarData.push({id : _i, day : _firstDayofCalendar.addDays(_i).getDate(), isToday : true, thisMonth : true});
				else
					_calendarData.push({id : _i, day : _firstDayofCalendar.addDays(_i).getDate(), isToday : false, thisMonth : true})
			else
				_calendarData.push({id : _i, day : _firstDayofCalendar.addDays(_i).getDate(), isToday : false, thisMonth : false});
		} 
		
		return _calendarData;	
	}	// End function GetMonthData
	
	function MoveMonthForward(){
		if($scope.getMonths.selectedOption.value + 1 == 12){
			if($scope.getYears.selectedOption + 1 > UPPERYEARLIMIT){
				// Disable forward cheveron		
			} else {
				$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[0];
				$scope.getYears.selectedOption = $scope.getYears.selectedOption + 1;
			}
		} else			
			$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[$scope.getMonths.selectedOption.value + 1];		
	}	// End function MoveMonthForward
	
	function MoveWeekForward(){
		if ($scope.getWeeks.selectedOption.value + 1 == 6){
			if($scope.getMonths.selectedOption.value + 1 == 12){
				if($scope.getYears.selectedOption + 1 > UPPERYEARLIMIT){
					// Disable forward cheveron	
				} else {
					$scope.getWeeks.selectedOption = $scope.getWeeks.availableOptions[0];
					$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[0];
					$scope.getYears.selectedOption = $scope.getYears.selectedOption + 1;
				}					
			} else {
				$scope.getWeeks.selectedOption = $scope.getWeeks.availableOptions[0];
				$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[$scope.getMonths.selectedOption.value + 1];
			}	
		} else
			$scope.getWeeks.selectedOption = $scope.getWeeks.availableOptions[$scope.getWeeks.selectedOption.value];
	}	// End function MoveWeekForward
	
	function MoveMonthBackward(){
		if ($scope.getMonths.selectedOption.value - 1 == -1){
			if ($scope.getYears.selectedOption - 1 < LOWERYEARLIMIT){
				// Disable forward cheveron		
			} else {
				$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[11];
				$scope.getYears.selectedOption = $scope.getYears.selectedOption - 1;
			}
		} else			
			$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[$scope.getMonths.selectedOption.value - 1];
	}	// End function MoveMonthBackward
	
	function MoveWeekBackward(){
		if ($scope.getWeeks.selectedOption.value - 1 == 0){
			if($scope.getMonths.selectedOption.value - 1 == -1){
				if(($scope.getYears.selectedOption - 1) < LOWERYEARLIMIT){
					// Disable forward cheveron	
				} else {
					$scope.getWeeks.selectedOption = $scope.getWeeks.availableOptions[4];
					$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[11];
					$scope.getYears.selectedOption = $scope.getYears.selectedOption - 1;
				}					
			} else {
				$scope.getWeeks.selectedOption = $scope.getWeeks.availableOptions[4];
				$scope.getMonths.selectedOption = $scope.getMonths.availableOptions[$scope.getMonths.selectedOption.value - 1];
			}	
		} else
			$scope.getWeeks.selectedOption = $scope.getWeeks.availableOptions[$scope.getWeeks.selectedOption.value - 2];
	}	// End function MoveWeekBackward
	
	// Initialize scope variables
	$scope.ShowView = function(viewName){
		switch(viewName){
			case "week":
				$scope.getViews.selectedOption = LoadViews().availableOptions[1];
				break;
			case "day":
				$scope.getViews.selectedOption = LoadViews().availableOptions[2];
				break;
			default:
				$scope.getViews.selectedOption = LoadViews().availableOptions[0];
				break;			
		}	// End switch
		
		$scope.GetCalendarData();
	}	// End function ShowMonthView
	
	$scope.GetCalendarData = function(){			
		switch($scope.getViews.selectedOption){
			case LoadViews().availableOptions[1]:
				$scope.calendarData = GetWeekData();
				break;
			default:
				$scope.calendarData = GetMonthData();
				break;			
		}	// End switch
	}	// End function GetCalendarDataData	
	
	$scope.MoveCalendarForward = function(){
		if($scope.getViews.selectedOption == "week")
			MoveWeekForward();
		else
			MoveMonthForward();
		
		$scope.GetCalendarData();
	}	// End function MoveCalendarForward
	
	$scope.MoveCalendarBackward = function(){
		if($scope.getViews.selectedOption == "week")
			MoveWeekBackward();
		else
			MoveMonthBackward();
		
		$scope.GetCalendarData();
	}	// End function MoveCalendarBackward
	
	// Initialize scope variables	
	$scope.getViews = LoadViews();
	$scope.getMonths = LoadMonths();
	$scope.getYears = LoadYears();		
	$scope.getWeeks = LoadWeeks();
	$scope.getDays = LoadDays($scope.getYears.selectedOption, $scope.getMonths.selectedOption.value);
	$scope.GetCalendarData();
});

/***
*	Reset Controller
***/
app.controller('ResetCtrl', function($scope, $location, locationHandler, userSession) {

	var showPanel = "username";
	var message = document.getElementById("message1");
	message.textContent = "";
	userSession.setSessionData("", locationHandler.getCurrentPageName(), "ResetRequest", new Date())
	$scope.resetQuestions = [];
	
	$scope.ShowPanel = function(){
		return showPanel;
	}	// End function ShowPanel
		
	$scope.ResetRequest = function (username) {
		
		userSession.setUserId(username);
		userSession.setEventTime(new Date());
		
		var request = $http({
			method: "post",
			url: "services/serviceHandler.php",
			data: {				
				sessionData: userSession.getSessionData(),
				errorMsg: "Your username could not be found. Please try again."
			},
			headers: { 'Content-Type' : 'application/json' }
		});

		/* Check whether the HTTP Request is successful or not. */
		request.success( function (data) {
			if( data.id > 0 ){
				message.textContent = data.message;
				message.style.display = "block";				
				message.className = "alert alert-danger";		
			} else {
				angular.forEach(data.message, function(value, key) {
					$scope.resetQuestions.push({ id : key, name : value, answer : "" });
				});	
				userSession.setEventTime(new Date());
				showPanel = "showQuestions";
			}	// End if
		});
	}	// End function ResetRequest
	
	$scope.ValidateAnswers = function (resetQuestions) {
		
		userSession.setEventName("ValidateAnswers");
		userSession.setEventTime(new Date());
		
		var request = $http({
			method: "post",
			url: "services/serviceHandler.php",
			data: {
				questions: $scope.resetQuestions,
				sessionData: userSession.getSessionData(),
				errorMsg: "Please try again."
			},
			headers: { 'Content-Type' : 'application/json' }
		});

		/* Check whether the HTTP Request is successful or not. */
		request.success( function (data) {
			if( data.id > 0 ){
				message = document.getElementById("message2");
				message.textContent = data.message;
				message.style.display = "block";				
				message.className = "alert alert-danger";		
			} else {
				userSession.setEventTime(new Date());
				showPanel = "showResetPassword"; 
			}
		});
	}	// End function ValidateAnswers
	
	$scope.ResetPassword = function (newPassword) {
		
		if( newPassword.pass1 == newPassword.pass2){		
			userSession.setEventName("ResetPassword");
			userSession.setEventTime(new Date());
			
			var request = $http({
				method: "post",
				url: "services/serviceHandler.php",
				data: {
					resetPassword: newPassword.pass1,
					sessionData: userSession.getSessionData(),
					errorMsg: "Your password could not be reset. Please try again."
				},
				headers: { 'Content-Type' : 'application/json' }
			});

			/* Check whether the HTTP Request is successful or not. */
			request.success( function (data) {
				if( data.id > 0 ){
					message = document.getElementById("message3");
					message.textContent = data.message;
					message.style.display = "block";				
					message.className = "alert alert-danger";		
				} else {
					userSession.setEventTime(new Date());
					$location.path("/login");
				}
			});
		} else {			
			message = document.getElementById("message3");
			message.textContent = "Your passwords don't match. Please try again";
			message.style.display = "block";				
			message.className = "alert alert-danger";
		}	// end if (pass1 == pass2)
	}	// End function ResetPassword
});

/***
*	Login Controller
***/
app.controller('LoginCtrl', function($scope, locationHandler, $location, $http, userSession) {
	
	// Alert the user that their password was successfully reset if returning from reset password page
	var message = document.getElementById("message");
	if( userSession.getEventName() == "ResetPassword" ){
		message.textContent = "Your password has been reset. Please enter your new password.";
		message.className = "alert alert-success";
		message.style.display = "block";		
	} else {	
		message.textContent = "";
	}	
	
	userSession.setSessionData("", locationHandler.getCurrentPageName(), "Login", new Date());
	
	$scope.SignIn = function (user) {		
	
		userSession.setUserId(user.id);
		
		var request = $http({
			method: "post",
			url: "services/serviceHandler.php",
			data: {
				userPass: user.password,
				sessionData: userSession.getSessionData(),
				errorMsg: "Your credentials could not be validated. Please try again."
			},
			headers: { 'Content-Type' : 'application/json' }
		});

		/* Check whether the HTTP Request is successful or not. */
		request.success( function (data) {
			if( data.id > 0 ){
				message.textContent = data.message;
				message.className = "alert alert-danger";
				message.style.display = "block"	;
				userSession.setUserId("");
			} else {
				userSession.setEventTime(new Date());
				$location.path("/dashboard");
			}
		});
	}
});

/***
*	Main Controller
***/
app.controller('MainCtrl', function($scope, $location, locationHandler) {	

    $scope.viewName = ($location.path() == "") ? 'login' : $location.path().substring(1);
	
	/***	Functions	***/
	$scope.$on("$locationChangeStart", function(e, currentLocation, previousLocation){
		locationHandler.setPreviousLocation(previousLocation);
		locationHandler.setCurrentLocation(currentLocation);
	});	
	
	$scope.ShowTopMenu = function(viewName) {
		var nonSessionViews = ["login", "reset"]
		return (nonSessionViews.indexOf(viewName) == -1 );
	}
	
	$scope.IsActive = function(viewName){
		return (viewName == 'dashboard' && $location.path().substring(1) != 'admin' ) ? true : ( $location.path().substring(1) == viewName ) ? true : false;
	}
});

app.factory('userSession', function () {
	
	//Private variables
	var session = {
        userId : "",
		pageName : "",
		eventName : "",
		eventTime : new Date()
    };	
	
	// Public functions
    return {
		getUserId : function(){
			return session.userId;
		},
		setUserId : function(value){
			session.userId = value;
		},
		getPageName : function(){
			return session.pageName;
		},
		setPageName : function(value){
			session.pageName = value;
		},
		getEventName : function(){
			return session.eventName;
		},
		setEventName : function(value){
			session.eventName = value;
		},
		getEventTime : function(){
			return session.eventTime;
		},
		setEventTime : function(value){
			session.eventTime = value;
		},
		getSessionData : function(){
			return session;
		},
		setSessionData : function(UserId, PageName, EventName, EventTime) {
			session.userId = UserId;
			session.pageName = PageName;
			session.eventName = EventName;
			session.eventTime = EventTime;
		}
    };
});

app.factory('locationHandler', function() {
    var currentLocation = "";
    var previousLocation = "";
    var locationService = {};
    
    locationService.getCurrentLocation = function() {
        return currentLocation;
    };
	locationService.setCurrentLocation = function(loc) {
        currentLocation = loc;
    };
	locationService.getCurrentPageName = function() {
		return currentLocation.slice((currentLocation.lastIndexOf("/") + 1) - currentLocation.length)
	}
	locationService.getPreviousLocation = function() {
        return previousLocation;
    };
	locationService.setPreviousLocation = function(loc) {
        previousLocation = loc;
    };
	locationService.getPreviousPageName = function() {
		return previousLocation.slice((previousLocation.lastIndexOf("/") + 1) - previousLocation.length)
	}
    
    return locationService;
});
