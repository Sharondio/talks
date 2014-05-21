<cf_format title="Show me some beers!">
<cfoutput>
<table class="table">
	<thead>
		<tr>
			<th>Name</th>
			<th>Brewery</th>
		</tr>
	</thead>
	<tbody>
		<tr ng-repeat="beer in beers">
			<td>{{beer.NAME}}</td>
			<td>{{beer.BREWERY}}</td>
		</tr>
	</tbody>
</table>

</cfoutput>
</cf_format>