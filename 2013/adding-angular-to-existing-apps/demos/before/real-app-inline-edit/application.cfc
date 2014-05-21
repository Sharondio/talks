<cfcomponent>

	<cfscript>
		this.name = "beers-demo";
		this.datasource = "beers";
	</cfscript>

	<cffunction name="onApplicationStart" returnType="boolean">
		<cfset application.data = createObject('component', 'data') />
		<cfset application.beers = application.data.getBeers() />
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean">
		<cfif NOT structKeyExists(application, 'data') OR isDefined("URL.reload") >
			<cfset application.data = createObject('component', 'data') />
			<cfset application.beers = application.data.getBeers() />
		</cfif>
		<cfreturn true />
	</cffunction>

	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string" />
		<cfreturn true />
	</cffunction>

</cfcomponent>