'use strict';

//App module.
var app = angular.module('real-app', []);

app.controller('MainCtrl', function($scope, $http) {

    $scope.title = "Basic App with Data";

    // This really belongs in a service, but it's fine in the controller for now.
    $http.get('data.cfc?method=getBeers').then(function(results) {
        $scope.beers = results.data;
    });

    $http.get('data.cfc?method=getCategories').then(function(results) {
        $scope.categories = results.data;
        $scope.filterItems = {};
        for(var cat in $scope.categories) {
            $scope.filterItems[$scope.categories[cat].CAT_NAME] = true;
        }
        $scope.catFilter = function(beer) {
            return $scope.filterItems[beer.CATEGORY];
        };
    });

});