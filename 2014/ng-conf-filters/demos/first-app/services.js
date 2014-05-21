/* Services */
var services = angular.module('app.services', [])

services.factory( 'Host', function($http) {
  // Host is a class which we can use for retrieving and 
  // updating data on the server
  var Host = function(data) { return data; //angular.extend(this, data); 
  }

  // a static method to retrieve Host by ID
  Host.get = function(id) {
    return $http.get('http://localhost:2404/hosts/' + id.host_id).then(function(response) { return new Host(response.data); });
  };

  Host.list = function() {
  //  return $http.get('http://localhost:2404/hosts/').then(function(response) { return new Host(response.data); })
    return $http.get('hosts.json').then(function(response, status) { return new Host(response.data); console.log(response.data); });
  };

  Host.update = function( data ) {
    return $http.put('http://localhost:2404/hosts/', data ).then(function(response) { return new Host(response.data); })
  }

  Host.create = function( data ) {
    return $http.put('http://localhost:2404/hosts/').then(function(response) { return new Host(response.data); })
  };

  Host.destroy = function(id) {
    return $http.delete('http://localhost:2404/hosts/' + id.host_id).then(function(response) { return new Host(response.data); })
  }

  // an instance method to create a new Host
  Host.prototype.create = function() {
    var host = this;
    return $http.post('http://localhost:2404/hosts/', host).then(function(response) {
      host.id = response.data.id;
      return host;
    });
  }

  return Host;
});

services.factory( 'Host_Config', function($http) {
  var Host_Config = function( data ) { angular.extend(this, data); }

  // a static method to retrieve Host_Config by ID
  Host_Config.get = function(id) {
    return $http.get('http://localhost:2404/host-configs/' + id).then(function(response) { return new Host_Config(response.data); });
  };

  // TODO: take the data array and parse it into the query instead of just accepting host_id
  Host_Config.list = function( data ) {
    return $http.get('http://localhost:2404/host-configs/?hostid=' + data.host_id).then(function(response) { return new Host_Config(response.data); })
  };

  Host_Config.create = function( data ) {
    return $http.put('http://localhost:2404/host-configs/').then(function(response) { return new Host_Config(response.data); })
  }

  // an instance method to create a new Host_Config
  Host_Config.prototype.create = function() {
    var host_config = this;
    return $http.post('http://localhost:2404/host-configs/', host_config).then(function(response) {
      host_config.id = response.data.id;
      return host_config;
    });
  }

  return Host_Config;
});