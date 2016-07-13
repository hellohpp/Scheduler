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
		otherwise({
			redirectTo: '/login'
		});		
});

/***
*	Dashboard Controller
***/
app.controller('DashboardCtrl', function($scope, $http, locationHandler, $location, userSession) {
	
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
app.controller('LoginCtrl', function($scope, locationHandler, $location, userSession) {
	
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
		return (viewName == '' && $location.path().substring(1) != 'admin' ) ? true : ( $location.path().substring(1) == viewName ) ? true : false;
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
