'use strict';

var filters = angular.module('app.filters', []);

filters.filter('makeFilterItems', function() {

        return function(items, filterOn, removeNulls) {

            if (filterOn === false) {
                return items;
            }

            if ((filterOn || angular.isUndefined(filterOn)) && angular.isArray(items)) {
                var hashCheck = {}, filterItems = {}
                filterItems.check = {}
                filterItems.list = []

                var extractValueToCompare = function(item) {
                    if (angular.isObject(item) && angular.isString(filterOn)) {
                        return item[filterOn];
                    } else {
                        return item;
                    }
                };

                items.sort(function(a, b) {
                    if (a[filterOn] > b[filterOn])
                        return 1;
                    if (a[filterOn] < b[filterOn])
                        return -1;
                    // a must be equal to b
                    return 0;
                });

                angular.forEach(items, function(item) {
                    var valueToCheck, isDuplicate = false;

                    for (var i = 0; i < filterItems.list.length; i++) {
                        if (angular.equals(extractValueToCompare(filterItems.list[i]), extractValueToCompare(item))) {
                            isDuplicate = true;
                            break;
                        }
                    }
                    if (removeNulls) {
                        if (item[filterOn]) {
                            filterItems.check[item[filterOn]] = true;
                            if (!isDuplicate) {
                                filterItems.list.push(item[filterOn])
                            }
                        }
                    } else {
                        if (!isDuplicate) {
                            filterItems.check[item[filterOn]] = true;
                            filterItems.list.push(item[filterOn])
                        }
                    }

                });

                return filterItems;
            };
        };
    });