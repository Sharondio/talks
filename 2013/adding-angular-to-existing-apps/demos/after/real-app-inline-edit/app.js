'use strict';

//App module.
var app = angular.module('real-app', ['ui.bootstrap']);

app.controller('MainCtrl', function($scope, $http, $modal) {

    $scope.title = "Basic App with Data";

    // This really belongs in a service, but it's fine in the controller for now.
    $http.get('data.cfc?method=getBeers').then(function(results) {
        $scope.beers = results.data;
        console.log($scope.beers);
    });

    $http.get('data.cfc?method=getCategories').then(function(results) {
        $scope.categories = results.data;
        $scope.filterItems = {};
        for(var cat in $scope.categories) {
            $scope.filterItems[$scope.categories[cat]] = true;
        }
        
        $scope.catFilter = function(beer) {
            return $scope.filterItems[beer.CATEGORY];
        };
    });

    $http.get('data.cfc?method=getStyles').then(function(results) {
        $scope.styles = results.data;
    });

    $http.get('data.cfc?method=getBreweries').then(function(results) {
        $scope.breweries = results.data;
        console.log('breweries: ', $scope.breweries)
    });

    $scope.show = function(beer) {
        if($scope.shown === beer) {
            $scope.shown = '';
        } else {
            $scope.shown=beer;
        }
    };

    $scope.update = function(beer) {
        $http.post('data.cfc?method=saveBeer').then(function(results) {
            $scope.message = "Beer Saved";
        });
    };
});

