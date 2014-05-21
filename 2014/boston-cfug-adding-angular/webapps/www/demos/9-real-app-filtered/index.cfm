<cfset id = application.beers[randRange(1, arrayLen(application.beers))] />
<cfset beer = application.data.getBeerDetail(id=id.id) />

<cf_format title="Always pick a demo topic you love...">
<cfoutput>

<div>
    <div class="hero-unit jumbotron">
      <h2>Beer of the day</h2>
      <h1>#beer.name#</h1>
      <h3>#beer.brewery# Brewery</h3>
      <p>#beer.city#, #beer.state#<cfif beer.country NEQ 'United States'>, #beer.country#</cfif></p>
    </div>
    <small>
        <strong>ABV:</strong> #beer.abv#</br />
        <strong>Style:</strong> #beer.style#</br />
        <strong>Category:</strong> #beer.category#</br />
        #beer.descript#<br />
    </small>
</div>

</cfoutput>
</cf_format>