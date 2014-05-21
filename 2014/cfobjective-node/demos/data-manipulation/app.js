var MongoClient = require('mongodb').MongoClient
var async = require('async')

MongoClient.connect('mongodb://localhost:27017/ngconf', function(err, db) {

    var filter = {
        country_code: {$ne: ''},
        ASN: {$ne: ''}, 
        date_time: {$ne: ''},
        registrar: {$ne: ''},
        domain_registrar: {$ne: ''},
        dns_host: {$ne: ''},
        ip: {$ne: ''},
        host_name: {$ne: ''}
    }

    var fields = {
        country_code: 1,
        ASN: 1,
        date_time: 1,
        registrar: 1,
        domain_registrar: 1,
        dns_host: 1,
        ip: 1,
        host_name: 1
    }

    var sortBy = {
        registrar: 1,
        country_code: 1,
        ASN: 1,
        domain_registrar: 1,
        dns_host: 1,
        ip: 1,
        host_name: 1
    }

    var docs = {
        name : "root",
        children : []
    }
    var counter = 0

    var bigArray = [
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000)
            buildStruct(1, cursor, cb)
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(25000)
            buildStruct(2, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(50000)
            buildStruct(3, cursor, cb)
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(75000)
            buildStruct(4, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(10000)
            buildStruct(5, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(125000)
            buildStruct(6, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(150000)
            buildStruct(7, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(175000)
            buildStruct(8, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(200000)
            buildStruct(9, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(225000)
            buildStruct(10, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(250000)
            buildStruct(11, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(300000)
            buildStruct(12, cursor, cb)          
        },
        function (cb) {
            var cursor = db.collection('dns').find(filter, fields);
            cursor.sort(sortBy).limit(25000).skip(325000)
            buildStruct(13, cursor, cb)          
        }
    ]

    async.series(bigArray, function (err) {
        console.log("ALL DONE")
        console.log(docs)
    })

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

    function buildStruct(index, cursor, cb) {
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

                    var IP = {
                        name : doc.ip,
                        children : []
                    }

                    if (!findInArray(doc.ip, docs.children[i1].children[i2].children[i3].children[i4].children)) {
                        // console.log(doc.domain_registrar + " > " + countryCodeASN.name + " > " + doc.registrar + " > " + doc.dns_host + " > " + doc.ip)
                        docs.children[i1].children[i2].children[i3].children[i4].children.push(IP)
                    }

                    var i5 = docs.children[i1].children[i2].children[i3].children[i4].children.length - 1

                    var Host = {
                        name: doc.host_name,
                        size: 0
                    }

                    if (!findInArray(doc.ip, docs.children[i1].children[i2].children[i3].children[i4].children[i5].children)) {
                        docs.children[i1].children[i2].children[i3].children[i4].children[i5].children.push(Host)
                    } else {
                        docs.children[i1].children[i2].children[i3].children[i4].children[i5].size++
                    }
                });
                cb()
            }
        ], function (err) {
            console.log("DONE: " + index)
        })
        cb()
    }

    
});