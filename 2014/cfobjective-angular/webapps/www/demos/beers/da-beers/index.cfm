<cfset request.beers = application.beers />
<cfparam name="url.page" default="1" />
<cfparam name="url.sortby" default="name" />
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
			<th><a href="#CGI.SCRIPT_NAME#?page=#URL.page#&sortBy=name<cfif URL.sortBy IS "name"> desc</cfif>">Name<cfif URL.sortBy IS "name"><span class="icon-chevron-down"><cfelseif URL.sortBy IS "name desc"><span class="icon-chevron-up"></cfif></a></th>
			<th><a href="#CGI.SCRIPT_NAME#?page=#URL.page#&sortBy=brewery<cfif URL.sortBy IS "brewery"> desc</cfif>">Brewery<cfif URL.sortBy IS "brewery"><span class="icon-chevron-down"><cfelseif URL.sortBy IS "brewery desc"><span class="icon-chevron-up"></cfif></a></th>
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
<cf_paginate data="#request.beers#" currentPage="#url.page#">
</cf_format>