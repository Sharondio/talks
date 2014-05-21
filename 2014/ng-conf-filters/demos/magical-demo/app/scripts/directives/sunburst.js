var directives = angular.module('app.directives', []);

directives.directive('sunburst', function() {

    //Width and height
    var width = 960,
        height = 900,
        radius = Math.min(width, height) / 2.2;

    return {
        restrict: 'E',
        terminal: true,
        scope: {
            items: '='
        },
        link: function(scope, element, attrs) {

            var x, y, color, svg, partition, arc, path, g, text

            function computeTextRotation(d) {
                var angle = x(d.x + d.dx / 2) - Math.PI / 2;
                return angle / Math.PI * 180;
            }

            function click(d) {
                // fade out all text elements
                text.transition().attr("opacity", 0);

                path.transition()
                    .duration(750)
                    .attrTween("d", arcTween(d))
                    .each("end", function(e, i) {
                        // check if the animated element's data e lies within the visible angle span given in d
                        if (e.x >= d.x && e.x < (d.x + d.dx)) {
                            // get a selection of the associated text element
                            var arcText = d3.select(this.parentNode).select("text");
                            // fade in the text element and recalculate positions
                            arcText.transition().duration(750)
                                .attr("opacity", 1)
                                .attr("transform", function() {
                                    return "rotate(" + computeTextRotation(e) + ")"
                                })
                                .attr("x", function(d) {
                                    return y(d.y);
                                });
                        }
                    });
            }

            svg = d3.select("body").append("svg")

            function clear() {
                d3.select("svg").remove()
                d3.selectAll("g").remove()
                d3.selectAll("text").remove()                
            }

            function buildSVG(root) {

                clear()

                x = d3.scale.linear()
                    .range([0, 2 * Math.PI]);

                y = d3.scale.sqrt()
                    .range([0, radius]);

                color = d3.scale.category20();

                svg = d3.select("body").append("svg")
                    .attr("width", width)
                    .attr("height", height)
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + (height / 2 + 10) + ")");

                partition = d3.layout.partition()
                    .value(function(d) {
                        return d.size;
                    });

                arc = d3.svg.arc()
                    .startAngle(function(d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x)));
                    })
                    .endAngle(function(d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx)));
                    })
                    .innerRadius(function(d) {
                        return Math.max(0, y(d.y));
                    })
                    .outerRadius(function(d) {
                        return Math.max(0, y(d.y + d.dy));
                    });

                path = svg.selectAll("path")
                    .data(partition.nodes(root))
                    .enter().append("path")
                    .attr("d", arc)
                    .style("fill", function(d) {
                        return color((d.children ? d : root).name);
                    })
                    .on("click", click);

                g = svg.selectAll("g")
                    .data(partition.nodes(root))
                    .enter().append("g");

                path = g.append("path")
                    .attr("d", arc)
                    .style("fill", function(d) {
                        return color((d.children ? d : root).name);
                    })
                    .on("click", click);

                text = g.append("text")
                    .attr("x", function(d) {
                        return y(d.y);
                    })
                    .attr("dx", "6") // margin
                    .attr("dy", ".35em") // vertical-align
                    .text(function (d) {
                        return d.name;
                    })

                text.attr("transform", function(d) {
                    return "rotate(" + computeTextRotation(d) + ")";
                });
            }

            // Trigger a rebuild
            scope.$watch('items', function (root) {
                if(root.name) {
                    clear()
                    buildSVG(root)
                }
            });

            d3.select(self.frameElement).style("height", height + "px");

            // Interpolate the scales!
            function arcTween(d) {
                var xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
                    yd = d3.interpolate(y.domain(), [d.y, 1]),
                    yr = d3.interpolate(y.range(), [d.y ? 20 : 0, radius]);
                return function(d, i) {
                    return i ? function(t) {
                        return arc(d);
                    } : function(t) {
                        x.domain(xd(t));
                        y.domain(yd(t)).range(yr(t));
                        return arc(d);
                    };
                };
            }
        }
    }
})