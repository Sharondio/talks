var five = require("johnny-five");
var config = require('./config.js')()
var Twit = require('twit');
var board, led;

// To use this code you'll need to create your own config.js: 
// module.exports = function() {
//     return {
//           consumer_key:         '[your consumer_key]'
//         , consumer_secret:      '[your consumer_service]'
//         , access_token:         '[your access_token]'
//         , access_token_secret:  '[your access_token_secret]'
//     }
// }

console.log("LOADING...."); 

var T = new Twit(config);
// array of twitter terms to watch
var watchList = ['cfobjective', 'coldfusion', 'railo', 'cfobjective2014', 'nodejs', 'raymondcamden', 'cfo2014node', 'mongodb', 'angularjs', 'boychuk'];
// open up the stream
var stream = T.stream('statuses/filter', { track: watchList })
// create arduino board instance
board = new five.Board();

board.on("ready", function() {
  console.log("BOARD READY");

  // Create a standard `led` hardware instance
  led = new five.Led({
    pin: 13
  });

  stream.on('tweet', function (tweet) {
    console.log("TWEET RECEIVED: ", tweet.text)
    led.on()
    setInterval( function () {
      led.off()
    }, 500)
  })

});