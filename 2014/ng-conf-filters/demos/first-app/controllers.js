'use strict';

var controllers = angular.module('app.controllers',[]);

controllers.controller('MainCtrl', function( $scope, $location, $routeParams, Host, $filter)  {
  
    //Just some global app vars
    $scope.title = "Hosts";
    $scope.user = {name: 'Sharon'};

    //Initial sort order
    $scope.orderProp = 'title';

    //Get Host 
    Host.list().then(function (data) {
      $scope.hosts = data;
    });
    
    //Little function to create the sort order click handler
    $scope.setOrder = function (orderProp) {
        $scope.orderProp = orderProp;
    };

    //Little function to create the host detail click handler
    $scope.getHost = function( host_id ) {
        var newRoute = "/" + host_id;
        $location.path( newRoute );
    };

});