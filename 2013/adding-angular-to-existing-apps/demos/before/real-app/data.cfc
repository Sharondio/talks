<cfcomponent output="true" displayname="Beers API">

	<cffunction name="getBeers" output="true">
		<cfargument name="name" default="" />
		<cfargument name="id" default=0 />
		<cfargument name="brewery_id" default="0" />
		<cfargument name="sortBy" default="name" />
		<cfargument name="paginate" default="false" />
		<cfargument name="maxRows" default="25" />
		<cfargument name="returnType" default="array" />

		<cfquery name="local.beers">
			SELECT B.id, B.name, B.abv, B.descript, BR.name AS 'brewery', S.style_name AS 'style', C.cat_name AS 'category'
			FROM beers B
			LEFT OUTER JOIN breweries BR
			ON B.brewery_id = BR.id
			LEFT OUTER JOIN styles S
			ON B.style_id = S.id
			LEFT OUTER JOIN categories C
			ON B.cat_id = C.id
			WHERE B.name IS NOT NULL
			AND B.name <> ''
			AND BR.name <> ''
			<cfif arguments.id>
				AND B.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" />
			</cfif>
			<cfif len(arguments.name)>
				AND B.name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" />
			</cfif>
			<cfif arguments.brewery_id>
				AND B.brewery_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.brewery_id#" />
			</cfif>
			ORDER BY #arguments.sortBy#
		</cfquery>

		<cfif arguments.returnType IS "array">
			<cfset local.result = queryToArray(local.beers) />
			<cfif arguments.paginate>
				<cfset local.result = makePages(local.result) />
			</cfif>
		<cfelse>
			<cfset local.result = local.beers />
		</cfif>
		
		<cfreturn local.result />
	</cffunction>

	<cffunction name="getBeerCount">
		<cfargument name="name" default="" />
		<cfargument name="brewery_id" default="0" />
		<cfquery name="local.beers">
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
		<cfreturn local.beers.beerCount />
	</cffunction>

	<cffunction name="getCategories">
		<cfquery name="local.categories">
			SELECT *
			FROM categories
			ORDER BY cat_name
		</cfquery>
		<cfset local.result = queryToArray(local.categories) />
		<cfreturn local.result />
	</cffunction>

	<cffunction name="getStyles">
		<cfquery name="local.styles">
			SELECT *
			FROM styles
			ORDER BY style_name
		</cfquery>
		<cfset local.result = queryToArray(local.styles) />
		<cfreturn local.result />
	</cffunction>

	<cffunction name="getBreweries">
		<cfquery name="local.breweries">
			SELECT *
			FROM breweries
			ORDER BY name
		</cfquery>
		<cfset local.result = queryToArray(local.breweries) />
		<cfreturn local.result />
	</cffunction>

	<cffunction name="queryToArray" access="package">
		<cfargument name="qData" type="query" />
		<cfset local.result = [] />
		<cfloop from="1" to="#arguments.qData.recordcount#" index="i">
			<cfset local.item = {} />
			<cfloop list="#arguments.qData.columnlist#" index="col">
				<cfset local.item[col] = arguments.qData[col][i] />
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