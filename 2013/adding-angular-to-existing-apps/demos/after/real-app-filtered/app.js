'use strict';

//App module.
var app = angular.module('real-app', []);

app.controller('MainCtrl', function($scope, $http) {

    $scope.title = "Basic App with Data";

    // This really belongs in a service, but it's fine in the controller for now.
    $http.get('data.cfc?method=getBeers').then(function(results) {
        $scope.beers = results.data;
        console.log(results);
    });

});