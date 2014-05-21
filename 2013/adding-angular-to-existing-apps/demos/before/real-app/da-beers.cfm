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

<table class="table">
	<thead>
		<tr>
			<th>Name</th>
			<th>Brewery</th>
		</tr>
	</thead>
	<tbody>
		<cfloop index="i" from="#start#" to="#end#">
			<tr>
				<td>#request.beers[i].name#</td>
				<td>#request.beers[i].brewery#</td>
			</tr>
		</cfloop>
	</tbody>
</table>

</cfoutput>
	
</cf_format>