'use strict';

angular.module('magicalDemoApp')
  .controller('MainCtrl', function ($scope, $http, $filter) {

    var makeFilterItems = $filter('makeFilterItems');

    $scope.count = 300;

    $scope.setCount = function () {
        console.log("Finding " + $scope.count + " items");
        $scope.status = "finding...";
        $scope.query = '';
        $http.get('http://localhost:3000/api/v1/dns?limit=' + $scope.count).then(function (results) {
            $scope.status = "done.";
            $scope.items = results.data;
            $scope.filter = makeFilterItems($scope.items, "country_code", true);
            console.log($scope.filter);
        });
    }

    $scope.setCount(300);

    //filter
    $scope.filterByCountry = function(item) {
        return $scope.filter.check[item.country_code];
    };

});