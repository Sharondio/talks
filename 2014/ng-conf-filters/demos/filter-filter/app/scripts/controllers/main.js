'use strict';

angular.module('myApp')
    .controller('MainCtrl', function ($scope, $http) {

        $http.get('http://localhost:3000/api/v1/beers').then(function(results) {
            $scope.beers = results.data;
        });

    });
