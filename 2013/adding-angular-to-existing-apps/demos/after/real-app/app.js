'use strict';

//App module.
var app = angular.module('real-app', []);

app.controller('MainCtrl', function($scope, $http) {

    // Set page title
    $scope.title = "Basic App with Data";

    // Get the beer data
    $http.get('data.cfc?method=getBeers').then(function(results) {
        $scope.beers = results.data;
        console.log($scope.beers);
    });

});