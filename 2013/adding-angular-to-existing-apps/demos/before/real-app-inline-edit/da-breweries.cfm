<cfset request.beers = application.data.getBeers(sortBy="brewery", returnType="query") />

<cf_format title="Show me some beers!">

    <cfoutput query="request.beers" group="brewery" maxrows="100">
        <br><strong>#brewery#</strong><br>
        <cfoutput>#name#<br></cfoutput>
    </cfoutput>

</cf_format>