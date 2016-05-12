(function(){
    var app = angular.module('store',[]);

    /***
    *   Main Page
    ***/
    app.controller('MainController', function () {
        this.pages = [
            { name: 'Availability', url: 'pages/availability.html' },
            { name: 'Jobs', url: 'pages/available-jobs.html' },
            { name: 'Police Request Forms', url: 'pages/job-request.html' }
        ];

        this.selected = this.pages[0];
        this.activeMenuOption = this.pages[0];

        this.PageSelected = function (value) {
            if (value.length > 1) {
                //toggle drop down list
                if (this.selected.length > 1) {
                    this.selected = this.activeMenuOption;
                } else {
                    this.activeMenuOption = this.selected;
                    this.selected = value;
                }
            } else {
                this.selected = value;
                this.activeMenuOption = this.selected;
            }
        }   // End function PageSelected

        this.IsPageSelected = function (value) {
            if (this.selected.length > 1) {
                return true;
            }
            else if (this.selected.name === value.name) {
                this.activeMenuOption.url = this.selected.url;
                return true;
            }
            return false;
        }   // End function IsPageSelected

        this.DisplaySelectedPage = function () {
            return this.activeMenuOption.url;
        }   // End function DisplaySelectedPage
    });

    /***
    *   User Availability Page
    ***/
    app.controller('WeekAvailableController', function () {
       
        this.tab = 1;

        this.ReloadRoute = function (value) {
            this.tab = value;
        };

    });    // End WeekAvailableController

    app.controller('WeekController', function(){

        this.am = 'AM';
        this.pm = 'PM';

        this.days = [
            { name: "Sunday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 50, pm: 60 }, order: 4 },
            { name: "Monday", weather: { am: 'images/severeStormDay-white.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 55, pm: 65 }, order: 5 },
            { name: "Tuesday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 45, pm: 63 }, order: 6 },
            { name: "Wednesday", weather: { am: 'images/severeStormDay-white.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 60, pm: 72 }, order: 7 },
            { name: "Thursday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 62, pm: 75 }, order: 1 },
            { name: "Friday", weather: { am: 'images/severeStormDay-white.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 58, pm: 68 }, order: 2 },
            { name: "Saturday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 40, pm: 55 }, order: 3 }
        ];

        this.ToggleActive = function (item) {
            item.showDay = (item.showDay === true) ? false : true;
            item.labelClass = (item.labelClass === "day-name") ? "" : "day-name";
        };

    });     // End WeekController

    /***
    *   Available Jobs Page
    ***/
    app.controller('JobController', function () {

        this.am = 'AM';
        this.pm = 'PM';
        this.showJobDetails = false;
        this.activeJob = {};

        this.days = [
            { name: "Sunday", weather: { am: 'images/partSun-gold.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 50, pm: 60 }, totalJobs: 35, order: 4, jobs: [{ id: 1, type: 'Patrol', place: 'Fairfield Main Public Library', address: '1080 Old Post Road', time: '3:00pm - 5:30pm', description: 'There is an event going on at the library', priority: 3, accept: true, reason: { id: 0, name: "---     Reason     ---" } }, { id: 2, type: 'Traffic', place: 'Stop and Shop', address: '1160 Kings Hwy Cutoff', time: '8:00am - 12:00pm', description: 'Dropping fiber optic lines into the ground outside Stop & Shop', priority: '2', accept: false, reason: { id: 2, name: "Past sixteen hour limit" } }, { id: 3, type: 'Crowd Control', place: 'Seagrape Cafe', address: '1144 Reef Rd', time: '9:00pm - 12:00am', description: 'Fairfield University students are having a graduation party', priority: 1, accept: true, reason: { id: 0, name: "---     Reason     ---" } }] },
            { name: "Monday", weather: { am: 'images/sun-Gold.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 55, pm: 65 }, totalJobs: 25, order: 5, jobs: [{ id: 4, type: 'Patrol', place: 'Fairfield Main Public Library', address: '1080 Old Post Road', time: '3:00pm - 5:30pm', description: 'There is an event going on at the library', priority: 3, accept: true, reason: { id: 2, name: "Past sixteen hour limit" } }, { id: 5, type: 'Traffic', place: 'Stop and Shop', address: '1160 Kings Hwy Cutoff', time: '8:00am - 12:00pm', description: 'Dropping fiber optic lines into the ground outside Stop & Shop', priority: '2', accept: false, reason: { id: 1, name: "Conflicts with schedule" } }, { id: 6, type: 'Crowd Control', place: 'Seagrape Cafe', address: '1144 Reef Rd', time: '9:00pm - 12:00am', description: 'Fairfield University students are having a graduation party', priority: 1, accept: true, reason: { id: 2, name: "Past sixteen hour limit" } }] },
            { name: "Tuesday", weather: { am: 'images/partSun-gold.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 45, pm: 63 }, totalJobs: 39, order: 6, jobs: [{ id: 7, type: 'Patrol', place: 'Fairfield Main Public Library', address: '1080 Old Post Road', time: '3:00pm - 5:30pm', description: 'There is an event going on at the library', priority: 3, accept: true, reason: { id: 0, name: "---     Reason     ---" } }, { id: 8, type: 'Traffic', place: 'Stop and Shop', address: '1160 Kings Hwy Cutoff', time: '8:00am - 12:00pm', description: 'Dropping fiber optic lines into the ground outside Stop & Shop', priority: '2', accept: true, reason: { id: 2, name: "Past sixteen hour limit" } }, { id: 9, type: 'Crowd Control', place: 'Seagrape Cafe', address: '1144 Reef Rd', time: '9:00pm - 12:00am', description: 'Fairfield University students are having a graduation party', priority: 1, accept: true, reason: { id: 1, name: "Conflicts with schedule" } }] },
            { name: "Wednesday", weather: { am: 'images/sun-Gold.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 60, pm: 72 }, totalJobs: 15, order: 7, jobs: [{ id: 10, type: 'Patrol', place: 'Fairfield Main Public Library', address: '1080 Old Post Road', time: '3:00pm - 5:30pm', description: 'There is an event going on at the library', priority: 3, accept: true, reason: { id: 0, name: "---     Reason     ---" } }, { id: 11, type: 'Traffic', place: 'Stop and Shop', address: '1160 Kings Hwy Cutoff', time: '8:00am - 12:00pm', description: 'Dropping fiber optic lines into the ground outside Stop & Shop', priority: '2', accept: false, reason: { id: 1, name: "Conflicts with schedule" } }, { id: 12, type: 'Crowd Control', place: 'Seagrape Cafe', address: '1144 Reef Rd', time: '9:00pm - 12:00am', description: 'Fairfield University students are having a graduation party', priority: 1, accept: true, reason: { id: 2, name: "Past sixteen hour limit" } }] },
            { name: "Thursday", weather: { am: 'images/partSun-gold.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 62, pm: 75 }, totalJobs: 22, order: 1, jobs: [{ id: 13, type: 'Patrol', place: 'Fairfield Main Public Library', address: '1080 Old Post Road', time: '3:00pm - 5:30pm', description: 'There is an event going on at the library', priority: 3, accept: true, reason: { id: 0, name: "---     Reason     ---" } }, { id: 14, type: 'Traffic', place: 'Stop and Shop', address: '1160 Kings Hwy Cutoff', time: '8:00am - 12:00pm', description: 'Dropping fiber optic lines into the ground outside Stop & Shop', priority: '2', accept: true, reason: { id: 0, name: "---     Reason     ---" } }, { id: 15, type: 'Crowd Control', place: 'Seagrape Cafe', address: '1144 Reef Rd', time: '9:00pm - 12:00am', description: 'Fairfield University students are having a graduation party', priority: 1, accept: true, reason: { id: 2, name: "Past sixteen hour limit" } }] },
            { name: "Friday", weather: { am: 'images/sun-Gold.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 58, pm: 68 }, totalJobs: 31, order: 2, jobs: [{ id: 16, type: 'Patrol', place: 'Fairfield Main Public Library', address: '1080 Old Post Road', time: '3:00pm - 5:30pm', description: 'There is an event going on at the library', priority: 3, accept: true, reason: { id: 0, name: "---     Reason     ---" } }, { id: 17, type: 'Traffic', place: 'Stop and Shop', address: '1160 Kings Hwy Cutoff', time: '8:00am - 12:00pm', description: 'Dropping fiber optic lines into the ground outside Stop & Shop', priority: '2', accept: false, reason: { id: 2, name: "Past sixteen hour limit" } }, { id: 18, type: 'Crowd Control', place: 'Seagrape Cafe', address: '1144 Reef Rd', time: '9:00pm - 12:00am', description: 'Fairfield University students are having a graduation party', priority: 1, accept: true, reason: { id: 1, name: "Conflicts with schedule" } }] },
            { name: "Saturday", weather: { am: 'images/partSun-gold.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 40, pm: 55 }, totalJobs: 18, order: 3, jobs: [{ id: 19, type: 'Patrol', place: 'Fairfield Main Public Library', address: '1080 Old Post Road', time: '3:00pm - 5:30pm', description: 'There is an event going on at the library', priority: 3, accept: true, reason: { id: 2, name: "Past sixteen hour limit" } }, { id: 20, type: 'Traffic', place: 'Stop and Shop', address: '1160 Kings Hwy Cutoff', time: '8:00am - 12:00pm', description: 'Dropping fiber optic lines into the ground outside Stop & Shop', priority: '2', accept: true, reason: { id: 0, name: "---     Reason     ---" } }, { id: 21, type: 'Crowd Control', place: 'Seagrape Cafe', address: '1144 Reef Rd', time: '9:00pm - 12:00am', description: 'Fairfield University students are having a graduation party', priority: 1, accept: true, reason: { id: 0, name: "---     Reason     ---" } }] }
        ];
        
        this.ToggleActive = function (item) {
            item.showDay = (item.showDay === true) ? false : true;
            item.labelClass = (item.labelClass === "day-name") ? "" : "day-name";
            item.textColor = (item.showDay === true) ? { 'color' : '#AEC8BE'} : "";
        };

        this.Reasons = [
            { id: 0, name: "---     Reason     ---" },
            { id: 1, name: "Conflicts with schedule" },
            { id: 2, name: "Past sixteen hour limit" }
        ]

        this.GetActiveJob = function () {
            return this.activeJob;
        };

        this.SetActiveJob = function (job) {
            this.showJobDetails = true;
            this.activeJob = job;
        };

        this.HideActiveJob = function () {
            this.showJobDetails = false;
        };
    });     // End WeekController

    app.controller('AvailableJobsController', function () {

        this.tab = 1;

        this.ReloadRoute = function (value) {
            this.tab = value;
        };

    });    // End AvailableJobsController

    /***
    *   Job Request
    ***/
    app.controller('JobRequestController', function () {

        this.am = 'AM';
        this.pm = 'PM';
        

        this.days = [
            { name: "Sunday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 50, pm: 60 }, order: 4 },
            { name: "Monday", weather: { am: 'images/severeStormDay-white.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 55, pm: 65 }, order: 5},
            { name: "Tuesday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 45, pm: 63 }, order: 6 },
            { name: "Wednesday", weather: { am: 'images/severeStormDay-white.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 60, pm: 72 }, order: 7 },
            { name: "Thursday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 62, pm: 75 }, order: 1 },
            { name: "Friday", weather: { am: 'images/severeStormDay-white.svg', pm: 'images/clearNight-white.svg' }, temp: { am: 58, pm: 68 }, order: 2 },
            { name: "Saturday", weather: { am: 'images/showersDay-white.svg', pm: 'images/partCloudNight-white.svg' }, temp: { am: 40, pm: 55 }, order: 3}
        ];

        this.header = { 
            reqName         : "Company Name", 
            client          : "Service Requested By",  
            minPayNotice    : "Notified of Minimum Payment", 
            payNotice       : "Payment Received", 
            instruction     : "For Instructions See", 
            billInfo        : "Billing Information",
            billTo          : "Bill To (if different than above)",
            address         : "Address"};

        this.ToggleActive = function (item) {
            item.showDay = (item.showDay === true) ? false : true;
            item.labelClass = (item.labelClass === "day-name") ? "" : "day-name";
        };
    });
})();