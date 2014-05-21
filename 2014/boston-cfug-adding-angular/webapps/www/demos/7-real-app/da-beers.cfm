<cfset breweries = application.breweries />
<cfset beers = application.beers />

<cfif structCount(form)>
	<cfset beers = application.data.getBeers(name=form.name, brewery_id=form.brewery) />
</cfif>

<cf_format title="Show me some beers!">

<cfoutput>

<div class="well">
	<strong>Search Options</strong>
	<div class="search">
		<form action="da-beers.cfm" class="form-inline" method="post">
			<label>Name:</label> <input type="text" name="name">
			<label>Brewery:</label>
			<select name="brewery">
				<option value="0">--- Choose Brewery---</option>
				<cfloop from="1" to="#arrayLen(breweries)#" index="i">
					<option value="#breweries[i].id#">#breweries[i].name#</option>
				</cfloop>
			</select>
			<input class="btn" type="submit" value="Search">
		</form>
	</div>
</div>

<cfif NOT arrayLen(beers)>
	<div class="alert alert-danger">No beers found</div>
</cfif>
<table class="table">
	<thead>
		<tr>
			<th>Name</th>
			<th>Brewery</th>
	</thead>
	<tbody>
		<cfloop array="#beers#" index="beer">
			<tr>
				<td>#beer.name#</td>
				<td>#beer.brewery#</td>
			</tr>			
		</cfloop>
	</tbody>
</table>

</cfoutput>
</cf_format>