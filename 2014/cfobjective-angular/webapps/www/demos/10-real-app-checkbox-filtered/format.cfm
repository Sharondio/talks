
<cfif thistag.executionmode IS "start">
<cfoutput>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Beers</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="/common/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="/common/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="/common/google-code-prettify/prettify.css" rel="stylesheet">
    <link href="/common/css/custom.css" rel="stylesheet">

    <script src="/common/google-code-prettify/prettify.js"></script>

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="/common/bootstrap/js/html5shiv.js"></script>
    <![endif]-->
  </head>

<body data-spy="scroll" data-target=".bs-docs-sidebar" ng-app="real-app">
<div class="navbar">
  <div class="navbar-inner">
    <ul class="nav">
        <li<cfif listLast(CGI.script_name, "/") EQ 'da-beers.cfm'> class="active"</cfif>><a href="da-beers.cfm"><i class="icon-chevron-right"></i>Da Beers!</a></li>
        <li<cfif listLast(CGI.script_name, "/") EQ 'index.cfm'> class="active"</cfif>><a href="index.cfm"><i class="icon-chevron-right"></i>Beer of Da Day</a></li>
<!---         <li<cfif listLast(CGI.script_name, "/") EQ 'da-breweries.cfm'> class="active"</cfif>><a href="da-breweries.cfm"><i class="icon-chevron-right"></i>Da Breweries</a></li>
        <li<cfif listLast(CGI.script_name, "/") EQ 'da-locations.cfm'> class="active"</cfif>><a href="da-locations.cfm"><i class="icon-chevron-right"></i>Da Location Search</a></li> --->
    </ul>
  </div>
</div>
<!-- Masthead
================================================== -->
<header class="jumbotron subhead" id="overview">
  <div class="container">
    <h1>#attributes.title#</h1>
  </div>
</header>



  <div class="container" ng-controller="MainCtrl">

    <!-- Docs nav
    ================================================== -->

      <div class="span9">
        <section>
</cfoutput>
<cfelse>
<cfoutput>
        </section>
      </div>
    </div>

  </div>



    <!-- Footer
    ================================================== -->
    <footer class="footer">
      <div class="container">
        <p>Adding AngularJS to Existing Apps - Boston-CFUG 2014 - @sharondio</p>
      </div>
    </footer>

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/common/jquery/jquery.js"></script>
    <script src="/common/bootstrap/js/bootstrap.js"></script>
    <script src="/common/angular/angular.min.js"></script>
    <script src="app.js"></script>

  </body>
</html>
</cfoutput>
</cfif>
