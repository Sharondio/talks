
var express = require('express');
var app = express();

app.get('/test.txt', function (req, res) {
    res.send('Hello World!');
});

var server = app.listen(3000, function () {
    console.log("listening on port %d", server.address().port);
});