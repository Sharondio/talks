'use strict';

angular.module('magicalDemoApp')
.controller('MainCtrl', function ($scope, $http, $filter) {

    $scope.status = "waiting...";
    $scope.filterOn = "TUCOW";
    $scope.filteredObject = {};
    var d3MakeObject = $filter('d3MakeObject');

    $scope.filterItems = function (filterBy) {
        console.log("items: " + $scope.items.length)
        $scope.filteredObject = d3MakeObject($scope.items, filterBy);
    }

    $scope.getData = function() {
        $scope.status = "finding...";
        $http.get('http://localhost:3000/api/v1/dns').then(function (results) {
            $scope.status = "ready.";
            $scope.items = results.data;
            $scope.filterItems($scope.filterOn);
        });
    }
    $scope.getData();

});