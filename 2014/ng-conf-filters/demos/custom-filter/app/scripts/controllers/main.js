'use strict';

angular.module('myApp')
    .controller('MainCtrl', function ($scope, $http, $filter) {

        var makeFilterItems = $filter('makeFilterItems');

        $http.get('http://localhost:3000/api/v1/beers').then(function(results) {
            $scope.beers = results.data;

            $scope.filter = makeFilterItems($scope.beers, "category", true);
            console.log($scope.beers)

        });

        //filter
        $scope.filterByCategory = function(item) {
            return $scope.filter.check[item.category];
        };

    });
