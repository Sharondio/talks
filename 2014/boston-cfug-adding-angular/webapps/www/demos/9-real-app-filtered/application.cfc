<cfcomponent>

	<cfscript>
		this.name = "beers-demo";
		this.datasource = "beers";
	</cfscript>

	<cffunction name="onApplicationStart" returnType="boolean">
		<cfset application.data = createObject('component', 'data') />
		<cfset application.beers = application.data.getBeers() />
		<cfset application.breweries = application.data.getBreweries() />
		<cfset application.categories = application.data.getCategories() />
		<cfset application.styles = application.data.getStyles() />
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean">
		<cfif isDefined("URL.refresh")>
			<cfset application.data = createObject('component', 'data') />
			<cfset application.beers = application.data.getBeers() />
			<cfset application.breweries = application.data.getBreweries() />
			<cfset application.categories = application.data.getCategories() />
			<cfset application.styles = application.data.getStyles() />
		</cfif>
		<cfreturn true />
	</cffunction>

	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string" />
		<cfreturn true />
	</cffunction>

</cfcomponent>