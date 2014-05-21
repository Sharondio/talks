'use strict';

angular.module('magicalDemoApp', [
  'ngRoute',
  'app.directives',
  'app.filters'
])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
