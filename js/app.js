var app = angular.module('oss', ['ngRoute']);

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
	locationService.getPreviousLocation = function() {
        return previousLocation;
    };
	locationService.setPreviousLocation = function(loc) {
        previousLocation = loc;
    };
    
    return locationService;
});

app.factory('userSession', function() {
    var username = "";
    var session = {};
    
    session.getSession = function() {
        return session;
    };
	session.setSession = function(sessionData) {
        session = sessionData;
    };
    
    return session;
});

app.config(function($routeProvider, $locationProvider) {
	$routeProvider.
		when('/login', {
		   templateUrl: 'views/login.html',
		   controller: 'LoginCtrl'
		}).
		when('/jobs', {
		   templateUrl: 'views/jobs.html'
		}).
		when('/admin', {
		   templateUrl: 'views/admin.html'
		}).
		otherwise({
			redirectTo: '/login'
		});		
});

app.controller('MainCtrl', function($scope, $location, locationHandler, $window, $route, $anchorScroll) {	

    $scope.viewName = ($location.path() == "") ? 'login' : $location.path().substring(1);
	
	/***	Objects		***/
	$scope.mainMenu = [
		{id: 0, shortname: "account", fullname:"My Account"}, 
		{id: 1, shortname: "jobs", fullname: "Jobs"},
		{id: 2, shortname: "admin", fullname: "Administration"}
	];
	
	/***	Functions	***/
	$scope.$on("$locationChangeStart", function(e, currentLocation, previousLocation){
		locationHandler.setPreviousLocation(previousLocation);
		locationHandler.setCurrentLocation(currentLocation);
	});	
	
	$scope.ShowTopMenu = function(viewName) {
		return (viewName != "login");
	}
});

app.controller('LoginCtrl', function($scope, $http, $window, userSession) {
	
	var message = document.getElementById("message");
	message.textContent = "";
	
	$scope.SignIn = function (user) {

		var request = $http({
			method: "post",
			url: "services/serviceHandler.php",
			data: {
				functionName: "login",
				userName: user.id,
				userPass: user.password,
				errorMsg: "Your credentials could not be validated. Please try again."
			},
			headers: { 'Content-Type' : 'application/x-www-form-urlencoded' }
		});

		/* Check whether the HTTP Request is successful or not. */
		request.success( function (data) {
			if( data.id > 0 ){
				message.textContent = data.message;
				message.style.display = "block"
			} else {
				/*
					 So the basic difference between the 2 methods is that 
					 $location.url() also affects get parameters whilst $location.path() does not.
					 
					 Use the database and user.id to track session data
				*/
				userSession.setSession = {userid : user.id, loginTime : new Date()};				
			}
		});
	}
});
