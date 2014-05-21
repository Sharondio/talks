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
<label>Filter By:</label><input ng-model="query">
<table class="table">
	<thead>
		<tr>
			<th>Name<a ng-click="sortBy='NAME'" class="icon-chevron-down"><a ng-click="sortBy='-NAME'" class="icon-chevron-up"></th>
			<th>Brewery<a ng-click="sortBy=['BREWERY','NAME']" class="icon-chevron-down"><a ng-click="sortBy=['-BREWERY','NAME']" class="icon-chevron-up"></th>
		</tr>
	</thead>
	<tbody>
		<tr ng-repeat="beer in beers | orderBy: sortBy | limitTo: 100 | filter: query">
			<td>{{beer.NAME}}</td>
			<td>{{beer.BREWERY}}</td>
		</tr>
	</tbody>
</table>

</cfoutput>
</cf_format>