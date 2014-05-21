<cfset beer = application.data.getBeers(id=URL.id)[1] />
<cfset categories = application.data.getCategories() />
<cfset styles = application.data.getStyles() />
<cfset breweries = application.data.getBreweries() />

<cf_format title="#beer.name#">

<cfoutput>
<form>
    <label>Name:</label><input style="width:400px;" type="text" name="name" value="#beer.name#" disabled>
    <label>Brewery:</label>
        <select name="brewery" style="width:400px;"  disabled>
            <cfloop from="1" to="#arrayLen(breweries)#" index="i">
                <option<cfif breweries[i].name IS beer.brewery> selected</cfif>>#breweries[i].name#</option>
            </cfloop>
        </select>
    <label>Style:</label>
        <select name="style" style="width:400px;" disabled>
            <cfloop from="1" to="#arrayLen(styles)#" index="s">
                <option<cfif styles[s].style_name IS beer.style> selected</cfif>>#styles[s].style_name#</option>
            </cfloop>
        </select>
    <label>Category:</label>
        <select name="category" style="width:400px;" disabled>
            <cfloop from="1" to="#arrayLen(categories)#" index="c">
                <option<cfif categories[c].cat_name IS beer.category> selected</cfif>>#categories[c].cat_name#</option>
            </cfloop>
        </select>
    <label>Description:</label><textarea disabled style="width:400px; height:100px;" name="descript">#beer.descript#</textarea>
</form>

<a href="da-beers.cfm">back</a>

</cfoutput>

</cf_format>