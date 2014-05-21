var MongoClient = require('mongodb').MongoClient
var async = require('async')
var fs = require('fs')

MongoClient.connect('mongodb://localhost:27017/ngconf', function(err, db) {

    // [ "afrinic", "apnic", "arin", "lacnic", "ripencc" ]

    var filter = {}

    var fields = {
        country_code : 1,
        ASN : 1,
        registrar : 1,
        domain_registrar : 1,
        dns_host : 1,
        host_name : 1
    }

    var sortBy = {
        domain_registrar: 1,
        country_code: 1,
        ASN: 1,
        registrar: 1,
        dns_host: 1,
        host_name: 1
    }

    var docs = {
        name : "root",
        children : []
    }
    var counter = 0

    var cursor = db.collection('dns').find(filter, fields);
    cursor.sort(sortBy)

    function findInArray(item, array, debug) {
        if (debug) {
            console.log("array: ", array, "item: ", item)
        }
        for(var i in array) {
            if (array[i].name == item) {
                if (debug) console.log("RETURN: true")
                return true
            }
        }
        if (debug) console.log("RETURN: false")
        return false
    }

    async.series([
        function (cb) {
            cursor.each(function (err, doc) {
                if (err) return cb(err)
                if (!doc) return cb()

                // console.log(doc)

                var domainRegistrar = {
                    name : doc.domain_registrar,
                    children : []
                }

                if (!findInArray(doc.domain_registrar, docs.children)) {
                    docs.children.push(domainRegistrar)
                }

                var i1 = docs.children.length - 1

                var countryCodeASN = {
                    name : doc.country_code + "_" + doc.ASN,
                    children : []
                }

                if (!findInArray(doc.country_code + "_" + doc.ASN, docs.children[i1].children)) {
                    docs.children[i1].children.push(countryCodeASN)
                }

                var i2 = docs.children[i1].children.length - 1

                var Registrar = {
                    name : doc.registrar,
                    children : []
                }

                if (!findInArray(doc.registrar, docs.children[i1].children[i2].children)) {
                    docs.children[i1].children[i2].children.push(Registrar)
                }

                var i3 = docs.children[i1].children[i2].children.length - 1

                var DNSHost = {
                    name : doc.dns_host,
                    children : []
                }

                if (!findInArray(doc.dns_host, docs.children[i1].children[i2].children[i3].children)) {
                    docs.children[i1].children[i2].children[i3].children.push(DNSHost)
                }

                var i4 = docs.children[i1].children[i2].children[i3].children.length - 1

                var Host = {
                    name: doc.host_name,
                    size: 10
                }

                if (!findInArray(doc.host_name, docs.children[i1].children[i2].children[i3].children[i4].children)) {
                    docs.children[i1].children[i2].children[i3].children[i4].children.push(Host)
                } else {
                    var i5 = docs.children[i1].children[i2].children[i3].children[i4].children.length - 1
                    docs.children[i1].children[i2].children[i3].children[i4].children[i5].size = docs.children[i1].children[i2].children[i3].children[i4].children[i5].size + 10
                }
            });
            cb()
        }
    ], function (err) {
        if (err) {
            console.log(err)
        }
        console.log("DONE!")
        if(docs.children.length) {
            fs.writeFile("data_object.json", JSON.stringify(docs, null, 4), function(err) {
                if(err) {
                    console.log(err);
                } else {
                    console.log("The file was saved!");
                }
            });
            console.log(docs.children[0].children.length + " records")
        }
    })
    
});