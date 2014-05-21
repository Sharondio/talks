
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
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="/bootstrap/css/google-prettify.css" rel="stylesheet">
    <link href="/styles/custom.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="/bootstrap/js/html5shiv.js"></script>
    <![endif]-->
  </head>

  <body data-spy="scroll" data-target=".bs-docs-sidebar" ng-app="real-app">

<!-- Masthead
================================================== -->
<header class="jumbotron subhead" id="overview">
  <div class="container">
    <h1>Beers!</h1>
    <p class="lead">#attributes.title#</p>
  </div>
</header>


  <div class="container" ng-controller="MainCtrl">

    <!-- Docs nav
    ================================================== -->
    <div class="row">
      <div class="span3 bs-docs-sidebar">
        <ul class="nav nav-list bs-docs-sidenav">
          <li><a href="da-beers.cfm"><i class="icon-chevron-right"></i>Beers!</a></li>
        </ul>
      </div>
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
        <p>Adding AngularJS to Existing Apps - NCDevCon 2013 - @sharondio</p>
      </div>
    </footer>

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/jquery/jquery-2.0.3.min.js"></script>
    <script src="/bootstrap/js/bootstrap.min.js"></script>
    <script src="/talks/common/angular/angular.min.js"></script>
    <script src="ui-bootstrap-custom-0.6.0.min.js"></script>
    <script src="ui-bootstrap-custom-tpls-0.6.0.min.js"></script>
    <script src="app.js"></script>

  </body>
</html>
</cfoutput>
</cfif>
