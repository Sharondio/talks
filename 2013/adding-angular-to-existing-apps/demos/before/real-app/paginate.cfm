<cfparam name="attributes.currentPage" default="1" />

<cfset curr = attributes.currentPage />
<cfset count = fix(arrayLen(attributes.data) / 25) />
<cfset page = CGI.script_name />
<cfif curr GTE 6>
    <cfset before_end = curr - 1 />
    <cfset before = curr - 5 />
<cfelse>
    <cfset before_end = curr - 1 />
    <cfset before = 1 />
</cfif>
<cfif curr LTE (count - 6)>
    <cfset after = 5 />
<cfelse>
    <cfset after = count - curr />
</cfif>

<cfoutput>
<!--- curr: #curr#<br>
count: #count#<br>
page: #page#<br>
before: #before#<br>
before_end: #before_end#<br>
after: #after#<br> --->
<div class="pagination">
  <ul>
    <cfif curr GT 1>
        <li><a href="#page#?page=1"><<</a></li>
        <li><a href="#page#?page=#curr - 1#">Prev</a></li>
    </cfif>
    <cfif before_end>
        <cfloop from="#before#" to="#before_end#" index="b">
            <li><a href="#page#?page=#b#">#b#</a></li>
        </cfloop>
    </cfif>
    <li class="active"><a href="##">#attributes.currentPage#</a></li>
    <cfif after>
        <cfloop from="1" to="#after#" index="a">
            <li><a href="#page#?page=#curr+a#">#curr+a#</a></i>
        </cfloop>
    </cfif>
    <cfif curr LT count>
        <li><a href="#page#?page=#curr + 1#">Next</a></li>
        <li><a href="#page#?page=#count#">>></a></li>
    </cfif>
  </ul>
</div> 
</cfoutput>