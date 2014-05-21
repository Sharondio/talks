<cfcomponent output="true" displayname="Beers API">

	<cffunction access="remote" name="getBeers" output="true" returnformat="JSON">
		<cfargument name="name" default="" />
		<cfargument name="brewery_id" default="0" />
		<cfargument name="sortBy" default="name" />
		<cfargument name="paginate" default="false" />
		<cfargument name="maxRows" default="25" />

		<cfset var beers=queryNew('id,name,brewery') />
		<cfset local.result = "" />

		<cfquery name="beers">
			SELECT B.id, B.name, B.abv, BR.name AS 'brewery', S.style_name AS 'style', C.cat_name AS 'category'
			FROM beers B
			LEFT OUTER JOIN breweries BR
			ON B.brewery_id = BR.id
			LEFT OUTER JOIN styles S
			ON B.style_id = S.id
			LEFT OUTER JOIN categories C
			ON B.cat_id = C.id
			WHERE B.name IS NOT NULL
			AND B.name <> ''
			AND B.descript <> ''
			AND B.brewery_id <> ''
			AND B.cat_id <> ''
			AND B.style_id <> ''
			<cfif len(arguments.name)>
				AND B.name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" />
			</cfif>
			<cfif arguments.brewery_id>
				AND B.brewery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.brewery_id#" />
			</cfif>
			ORDER BY #arguments.sortBy#
		</cfquery>

		<cfset local.result = queryToArray(beers) />
		<cfif arguments.paginate>
			<cfset local.result = makePages(local.result) />
		</cfif>
		
		<cfreturn local.result />
	</cffunction>

	<cffunction access="remote" name="getBeerCount"  returnformat="JSON">
		<cfargument name="name" default="" />
		<cfargument name="brewery_id" default="0" />
		<cfquery name="beers">
			SELECT count(*) AS 'beerCount'
			FROM beers B
			WHERE 1 = 1
			<cfif len(arguments.name)>
				AND B.name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" />
			</cfif>
			<cfif arguments.brewery_id>
				AND B.brewery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.brewery_id#" />
			</cfif>
		</cfquery>
		<cfreturn beers.beerCount />
	</cffunction>

	<cffunction access="remote" name="getBeerDetail" returnformat="JSON">
		<cfargument name="id" default=0 />
		<cfquery name="local.beer">
			SELECT B.name, B.abv, B.descript, BR.name AS 'brewery', BR.city, BR.state, BR.country, C.cat_name AS 'category', S.style_name AS 'style', G.longitude, G.latitude
			FROM beers B
			LEFT OUTER JOIN breweries BR
			ON B.brewery_id = BR.id
			LEFT OUTER JOIN styles S
			ON B.style_id = S.id
			LEFT OUTER JOIN categories C
			ON B.cat_id = C.id
			LEFT OUTER JOIN geocodes G
			ON BR.id = G.brewery_id
			WHERE B.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" />
			AND B.descript <> ''
			AND B.brewery_id <> ''
			AND B.cat_id <> ''
			AND B.style_id <> ''
		</cfquery>
		<cfset local.result = queryToArray(qData=local.beer) />
		<cfreturn local.result[1] />
	</cffunction>

	<cffunction access="remote" returnformat="JSON" name="getCategories">
		<cfquery name="local.categories">
			SELECT id, cat_name
			FROM categories
			WHERE cat_name <> ''
			ORDER BY cat_name
		</cfquery>
		<cfset local.result = queryToArray(qData=local.categories,listify=true) />
		<cfreturn local.result />
	</cffunction>

	<cffunction access="remote" returnformat="JSON" name="getStyles">
		<cfquery name="local.styles">
			SELECT id, style_name
			FROM styles
			ORDER BY style_name
		</cfquery>
		<cfset local.result = queryToArray(qData=local.styles,listify=true) />
		<cfreturn local.result />
	</cffunction>

	<cffunction access="remote" returnformat="JSON" name="getBreweries">
		<cfquery name="local.breweries">
			SELECT id, name
			FROM breweries
			ORDER BY name
		</cfquery>
		<cfset local.result = queryToArray(qData=local.breweries) />
		<cfreturn local.result />
	</cffunction>

	<cffunction access="remote" name="saveBeer" returnformat="JSON">
		<!--- cheating this one --->
		<cfreturn true />
	</cffunction>

	<cffunction name="queryToArray" access="package">
		<cfargument name="qData" type="query" />
		<cfargument name="listify" type="boolean" default="false" /> 
		<cfset local.result = [] />
		<cfloop from="1" to="#arguments.qData.recordcount#" index="i">
			<cfset local.item = {} />
		
			<cfloop list="#arguments.qData.columnlist#" index="col">
				<cfif arguments.listify>
					<cfset local.item = arguments.qData[col][i] />
				<cfelse>
					<cfset local.item[col] = arguments.qData[col][i] />
				</cfif>
			</cfloop>
			
			<cfset arrayAppend(local.result, local.item) />
		</cfloop>
		<cfreturn local.result />
	</cffunction>

	<cffunction name="makePages" access="package">
		<cfargument name="qData" />
		<cfargument name="itemsPerPage" default="25" />

		<cfset local.result = [] />
		<cfset local.count = arrayLen(arguments.qData) />
		<cfset local.pages = ceiling(arrayLen(arguments.qData) \ arguments.itemsPerPage) />
		<cfset local.i = 0 />
		<cfset local.ii = 0 />
		<cfset local.item = 0 />

		<cfloop from="1" to="#local.pages#" index="local.i">
			<cfif (local.i MOD arguments.itemsPerPage)>
				<cfset local.ii = 1/>
				<cfset local.result[local.i] = arrayNew(1) />
			</cfif>
			<cfloop from="1" to="#arguments.itemsPerPage#" index="local.ii" >
				<cfset local.item = local.item + 1 />
				<cfif local.item LTE local.count>
					<cfset local.result[local.i][local.ii] = arguments.qData[local.item] />
				</cfif>
			</cfloop>
		</cfloop>

		<cfreturn local.result />
	</cffunction>

</cfcomponent>