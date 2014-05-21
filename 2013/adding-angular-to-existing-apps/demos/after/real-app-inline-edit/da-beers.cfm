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
			<th>Name<a ng-click="sortBy='NAME'" class="icon-chevron-down"><a ng-click="sortBy='-NAME'" class="icon-chevron-up"></th>
			<th>Brewery<a ng-click="sortBy='BREWERY'" class="icon-chevron-down"><a ng-click="sortBy='-BREWERY'" class="icon-chevron-up"></th>
			<th>Category<a ng-click="sortBy='CATEGORY'" class="icon-chevron-down"><a ng-click="sortBy='-CATEGORY'" class="icon-chevron-up"></th>
		</tr>
	</thead>
	<tbody ng-repeat="beer in beers | orderBy: sortBy | limitTo: 50 | filter: catFilter">
		<tr ng-click="show(beer)">
			<td>{{beer.NAME}}</td>
			<td>{{beer.BREWERY}}</td>
			<td>{{beer.CATEGORY}}</td>
		</tr>
		<tr ng-show="shown == beer">
			<td colspan="3">
				<form>
					<div class="form_container">
						<h4>Edit Beer</h4>
						<div class="form_row">
							<label>Name:</label><input style="width:260px;" ng-model="beer.NAME" />
						</div>
						<div class="form_row">
							<label>Brewery:</label>
							<select ng-model="beer.BREWERY" style="width:260px;" ng-options="b for b in breweries"><option value="">Choose Brewery</option></select>
						</div>
						<div class="form_row">
							<label>Category:</label>
							<select ng-model="beer.CATEGORY" style="width:260px;" ng-options="c for c in categories"><option value="">Choose Category</option></select>
						</div>
						<div class="form_row">
							<label>Style:</label>
							<select ng-model="beer.STYLE" style="width:260px;" ng-options="s for s in styles"><option value="">Choose Style</option></select>
						</div>
						<div class="form_row">
							<label>Description:</label>
							<textarea style="width: 460px;" ng-model="beer.DESCRIPT"></textarea>
						</div>
						<div class="form_row">
							<label>Alcohol:</label>
							<input style="width: 15px;" ng-model="beer.ABV" />
						</div>
						<div class="form_button">
							<button type="button">Cancel</button>
							<button type="button">Save</button>
						</div>
					</div>
				</form>
			</td>
		</tr>
	</tbody>
</table>

<!--- modal template --->
<div>
    <script type="text/ng-template" id="myModalContent.html">
        <div class="modal-header">
            <h3>Edit {{beer.NAME}}</h3>
        </div>
        <div class="modal-body">
            
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" ng-click="save()">Save</button>
            <button class="btn btn-warning" ng-click="cancel()">Cancel</button>
        </div>
    </script>
</div>


</cfoutput>
</cf_format>