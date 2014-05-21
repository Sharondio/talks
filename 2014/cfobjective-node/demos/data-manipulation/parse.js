// node samples/sample.js

var fs = require('fs');
var csv = require('csv');

// opts is optional
// var opts = ;

var headers = []

csv()
.from.path(__dirname+'/dns_data.csv', { delimiter: ',', escape: '"' })
.transform( function(row){
    if (row[0] === '_id') {
        headers = row;
        // return null
    } else {
        row[12] = row[12].replace(/\[SLASH\]/g, "/")
        var line = row[3].split('/')
        var IP = line[2] + "." + line[3] + '.' + line[4] + '.' + line[5]
        row.push(line[0])
        row.push(IP)
        row.push(line[6])
        row.push(line[7])
        row.push(line[8])
        //row.push(headers)
        // console.log("ROW: ", row)

        // var newRow = {}
        // for (var i = 0; i < headers.length; i++) {
        //     newRow[headers[i]] = row[i]
        // }

        // console.log(newRow)
    }
    return row;
})
.to.stream(fs.createWriteStream(__dirname+'/dns_data_out.csv'))
.on('record', function(row,index){
  // console.log('#'+index+' '+JSON.stringify(row));
  console.log(index)
})
.on('close', function(count){
  // when writing to a file, use the 'close' event
  // the 'end' event may fire before the file has been written
  console.log('Number of lines: '+count);
})
.on('error', function(error){
  console.log(error.message);
});
// Output:
// #0 ["2000-01-01","20322051544","1979.0","8.8017226E7","ABC","45"]
// #1 ["2050-11-27","28392898392","1974.0","8.8392926E7","DEF","23"]
// Number of lines: 2