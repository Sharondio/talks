<cf_format title="Show me some beers!">
<cfoutput>
	<div class="filter_container">
		<label>Filter By:</label>
		<div class="filter_checkboxes" ng-repeat = "cat in categories">
			<input type="checkbox" ng-model="filterItems[cat]"> {{cat}}
		</div>
	</div>
<table class="table">
	<thead>
		<tr>
			<th>Name
				<a ng-click="sortBy='NAME'" class="icon-chevron-down">
				<a ng-click="sortBy='-NAME'" class="icon-chevron-up">
			</th>
			<th>Brewery
				<a ng-click="sortBy='BREWERY'" class="icon-chevron-down">
				<a ng-click="sortBy='-BREWERY'" class="icon-chevron-up">
			</th>
			<th>Category
				<a ng-click="sortBy='CATEGORY'" class="icon-chevron-down">
				<a ng-click="sortBy='-CATEGORY'" class="icon-chevron-up">
			</th>
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