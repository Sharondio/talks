<cfset request.beers = application.beers />
<cfparam name="url.page" default="1" />
<cfparam name="url.sortBy" default="name" />
<cfset start = 25 * url.page />
<cfset end = start + 25 />
<cfif end GT arrayLen(request.beers)>
	<cfset end = arrayLen(request.beers) />
</cfif>
<cfif isDefined("URL.sortBy")>
	<cfset request.beers = application.data.getBeers(sortBy=URL.sortBy) />
</cfif>


<cf_format title="Show me some beers!">
<cfoutput>
<label>Filter By:</label>
<div ng-repeat = "cat in categories">
	<input type="checkbox" ng-model="filterItems[cat.CAT_NAME]"> {{cat.CAT_NAME}}
</div>
<table class="table">
	<thead>
		<tr>
			<th>Name<a ng-click="sortBy='NAME'" class="icon-chevron-down"><a ng-click="sortBy='-NAME'" class="icon-chevron-up"></th>
			<th>Brewery<a ng-click="sortBy='BREWERY'" class="icon-chevron-down"><a ng-click="sortBy='-BREWERY'" class="icon-chevron-up"></th>
			<th>Category<a ng-click="sortBy='CATEGORY'" class="icon-chevron-down"><a ng-click="sortBy='-CATEGORY'" class="icon-chevron-up"></th>
		</tr>
	</thead>
	<tbody>
		<tr ng-repeat="beer in beers | orderBy: sortBy | limitTo: 50 | filter: catFilter">
			<td>{{beer.NAME}}</td>
			<td>{{beer.BREWERY}}</td>
			<td>{{beer.CATEGORY}}</td>
		</tr>
	</tbody>
</table>

</cfoutput>
</cf_format>