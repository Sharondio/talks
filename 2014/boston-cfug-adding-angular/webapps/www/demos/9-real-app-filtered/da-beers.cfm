<cf_format title="Show me some beers!">
<cfoutput>
<label>Filter By:</label><input ng-model="query">
<table class="table">
	<thead>
		<tr>
			<th>Name
			<a ng-click="sortBy='NAME'" class="icon-chevron-down">
			<a ng-click="sortBy='-NAME'" class="icon-chevron-up"></th>
			<th>Brewery
			<a ng-click="sortBy=['BREWERY','NAME']" class="icon-chevron-down">
			<a ng-click="sortBy=['-BREWERY','NAME']" class="icon-chevron-up"></th>
		</tr>
	</thead>
	<tbody>
		<tr ng-repeat="beer in beers | filter: query | orderBy: sortBy | limitTo: 100 ">
			<td>{{beer.NAME}}</td>
			<td>{{beer.BREWERY}}</td>
		</tr>
	</tbody>
</table>

</cfoutput>
</cf_format>