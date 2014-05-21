<cfset request.beers = application.data.getBeers(sortBy="style", returnType="query") />

<cf_format title="Show me some beers!">

    <cfoutput query="request.beers" group="style" maxrows="100">
        <cfif len(style)>
            <br><strong>STYLE: #style#</strong><br>
            <cfoutput>#name#<br></cfoutput>
        </cfif>
    </cfoutput>

</cf_format>