var http = require('http');
var express = require('express');
var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var ObjectId = Schema.ObjectId;
var restify = require('express-restify-mongoose')

mongoose.connect('mongodb://localhost/ngconf');
var beerSchema = new Schema({
  _id: ObjectId,
  id: Number,
  brewery: {
    name: String,
    country: String,
    state: String,
    city: String,
    geocodes: {
      longitude: Number,
      latitude: Number
    }
  },
  name: String,
  category: String,
  style: String,
  abv: Number,
  descript: String
});

var dnsSchema = new Schema({
  _id: ObjectId,
  name: String,
  record_type: String,
  mal4s_string: String,
  data: String,
  country_code: String,
  ASN: String,
  reverse_dns: String,
  registrar: String,
  date_time: String,
  http_request: String,
  http_response: String,
  url: String,
  malware_hash: String,
  registrar: String,
  ip: String,
  dns_host: String,
  domain_registrar: String,
  host_name: String
})

var Beers = mongoose.model('beers', beerSchema);
var dns = mongoose.model('dns', dnsSchema);

var app = express();
var options = {
  access : function (request) {
    return 'public'
  }
}

app.configure(function(){
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(
      function crossOrigin(req,res,next){
        res.header("Access-Control-Allow-Origin", "*");
        res.header("Access-Control-Allow-Headers", "X-Requested-With");
        return next();
      }
    );

    restify.serve(app, Beers, options);
    restify.serve(app, dns, options);
});

http.createServer(app).listen(3000, function() {
    console.log("Express server listening on port 3000");
});