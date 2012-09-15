"use strict"

# Declare app level module which depends on filters, and services
angular.module("myApp", ["myApp.filters", "myApp.services", "myApp.directives"]).config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "partials/main.html"
    controller: MainCtrl

  $routeProvider.when "/start",
    templateUrl: "partials/start.html"
    controller: StartCtrl

  $routeProvider.when "/filepicker",
    templateUrl: "partials/filepicker.html"
    controller: MyCtrl2

  $routeProvider.otherwise redirectTo: "/"
]