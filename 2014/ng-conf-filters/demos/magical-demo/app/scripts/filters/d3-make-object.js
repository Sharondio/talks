'use strict';

var filters = angular.module('app.filters', []);

filters.filter('d3MakeObject', function () {

    return function (data, filterBy) {

        var filteredItems = []

        var docs = {
            name : "root",
            children : []
        }

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

        for(var i in data) {
            var push = false
            for(var key in data[i]) {
                if (typeof data[i][key] === 'string' && data[i][key].indexOf(filterBy) !== -1) {
                    push = true
                } else if(filterBy == data[i][key]) {
                    push = true
                }
            }
            if(push) {
                filteredItems.push(data[i])
            }
        }

        angular.forEach(filteredItems, function (doc) {
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

        })

        return docs

    }

})