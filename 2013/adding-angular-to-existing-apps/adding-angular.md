# Adding AngularJS to Existing Apps
### Getting the UI Sugar...Without the jQuery Pain

NCDevCon, September 2013

Sharon DiOrio &bull; [@sharondio](https://twitter.com/sharondio)

<aside class="notes">Hi, my name is Sharon, and I'm a recovering ColdFusion Developer.
  [pause for "hi sharon"]
  I'm currently a Senior Web Developer for Euro-Pro. We're a Billion-dollar company that nobody has ever heard of. Sort of. We make the shark vacuum and ninja kitchen products. You may have seen our owner on late-night infomercials selling vacuums and steam mops.
</aside>



## My story
### ColdFusion was my life
<img src="images/old_school.png">

<aside class="notes">It all began when my Filemaker Pro rep went to Allaire and called me about this cool new software I should look at. I went to the demo with a colleague who was doing web work with Oracle web server. We watched the simple demos with CF talking to the DB and displaying data. Her jaw hung open. She shared that that little bit of magic would've taken her 3 days of coding with Oracle. So I immediately got ahold of a demo copy of CF version 3.0 (the first hit is free) and tied a database to the web for the first time. I knew then, I was hooked.</aside>


## Blatant Brag Slide

<img src="images/achieve.jpeg" class="logo">
<img src="images/bcg.jpeg" class="logo">
<img src="images/bgcb.jpeg" class="logo">
<img src="images/hasbro.jpeg" class="logo">
<img src="images/reebok.jpeg" class="logo">
<img src="images/sentient.jpeg" class="logo">
<img src="images/stjude.jpeg" class="logo">

<aside class="notes">In order to feed my habit, I found positions with various companies. Fortunately for me, ColdFusion has served as a sort of "prescreening" for companies I'd want to work for. Pragmatic companies. Companies that made technical decisions based on the right tool rather than whatever MS was peddling.</aside>



## Why move to Javascript?

<aside class="notes">Note: I was always able to find CF work. That's never been the problem. In fact, even now I get recruiters contacting me for CF. But I was getting bored. I didn't get the same "high" I'd gotten in years past from doing cool stuff. I knew it was time to add to the toolbox, but what to choose? It was very apparent to me that that market was evolving rapidly. Instead of heavy middleware apps, people were migrating to well-organized services and putting more logic in the client.</aside>



### On Javascript

> "Every developer loves and hates JavaScript a little bit."

<small>~ Jeremy Foster</small>

### But...

> "Learning JavaScript used to mean you weren't a serious software developer. Today, not learning Javascript means the same thing."

<small>~ Tim O'Reilly</small>

<aside class="notes">
  Am I the only one that remembers when the front-end developers were the low guys on the totem pole?
</aside>




## Why Angular?

<img src="images/popularity.jpeg" width="800">

<small>graphic courtesy of David Corbacho</small>

<aside class="notes">If you can't really see the slide, the blue line is AngularJS, the red line is node.js and the green line is backbone. Ember is down there at the bottom in purple. Hey, somebody tell Sean Corfield that Clojure is more popular than Ember and Backbone!
<br><br>
  So Angular is popular. So popular it's actually hip. Because most of you are Coldfusion people, I will assume that you're not here because Angular is hip. 
<br><br>
  When I started at Euro-Pro, we were using CanJS on the front-end and python web services with MS SQL via ORM on the back-end.
 It was pretty clunky, so I was tasked with finding new options. Evaluating frameworks is overwhelming. I read blog posts and played with demos. Then I got to Angular. In one night, I'd rewritten a common list interface that was plaguing us in one of our apps. I brought it in to demo to my boss (one of the reasons for learning this stuff) and we just grinned. We'd found our framework. As an aside, the community surrounding this framework is probably the best I've experienced since CF.</aside>



##Why this talk?
### Plenty of demos, do we need more?
We do when your code looks something like this<sup>*</sup>:
```
  <CFIF request.StatusCode EQ "30" OR request.StatusCode EQ "31" OR request.StatusCode EQ "32">
      <CFSTOREDPROC procedure="dbo.spAppendRFQQuestions" DATASOURCE="#session.ds4#">
        <CFPROCPARAM type="IN" dbvarname="@QuoteID"           value="#request.QuoteID#"          CFSQLTYPE="CF_SQL_INTEGER">
        <CFPROCPARAM type="IN" dbvarname="@DecisionMaker"     value="#request.DecisionMaker#"    CFSQLTYPE="CF_SQL_BIT">
        <CFPROCPARAM type="IN" dbvarname="@DecisionDate"      value="#request.DecisionDate#"     CFSQLTYPE="CF_SQL_INTEGER">
        <CFPROCPARAM type="IN" dbvarname="@EventType"          value="#request.EventType#"         CFSQLTYPE="CF_SQL_INTEGER">
        <CFPROCPARAM type="IN" dbvarname="@EventPurpose"       value="#request.EventPurpose#"      CFSQLTYPE="CF_SQL_VarCHAR">
        <CFPROCPARAM type="IN" dbvarname="@BudgetID"          value="#request.BudgetID#"         CFSQLTYPE="CF_SQL_INTEGER">
        <CFPROCPARAM type="IN" dbvarname="@CloseProbability"  value="#request.CloseProbability#" CFSQLTYPE="CF_SQL_INTEGER">
        <CFPROCPARAM type="IN" dbvarname="@AdminID"           value="#request.UserID#"           CFSQLTYPE="CF_SQL_INTEGER">
      </CFSTOREDPROC>
    <CFELSEIF request.StatusCode EQ "17">
      <CFQUERY DATASOURCE="#session.ds4#" NAME="UpdateQuoteCount">
        UPDATE dbo.tblUsers
        SET TotalEvents = TotalEvents - 1
        WHERE UserID = #request.thisClientID#
      </CFQUERY>
      <CFQUERY DATASOURCE="#session.ds4#" NAME="rstReSetConfDate">
        UPDATE dbo.tblQuote
        SET ConfirmedDate = NULL
        WHERE (dbo.tblQuote.QuoteID = #request.QuoteID#)
      </CFQUERY>
      <CFSTOREDPROC procedure="dbo.spReportPriceCost" DATASOURCE="#session.ds4#">
        <CFPROCPARAM type="IN" dbvarname="@QuoteID" value="#request.QuoteID#" CFSQLTYPE="CF_SQL_INTEGER">
        <CFPROCRESULT name="rstEventDetail" resultset="1">
        <CFPROCRESULT name="rstSectionDetail"  resultset="2">
      </CFSTOREDPROC>
      <CFTRY>
        <CFIF request.SendEmail>
          <CFSET thisProj = "">
          <CFLOOP query="rstSectionDetail">
            <CFIF thisProj EQ "">
              <CFSET thisProj = "#rstSectionDetail.SectionNum#. #dateformat(rstSectionDetail.start, "mm/dd/yy")# #timeformat(rstSectionDetail.start, "HH:mm")# lcl -- #rstSectionDetail.Orig# -> #rstSectionDetail.Dest#">
            <CFELSE>
              <CFSET thisProj = "#thisProj#-#rstSectionDetail.SectionNum#. #dateformat(rstSectionDetail.start, "mm/dd/yy")# #timeformat(rstSectionDetail.start, "HH:mm")# lcl -- #rstSectionDetail.Orig# -> #rstSectionDetail.Dest#" />
            </CFIF>
          </CFLOOP>
        <table cellpadding="3" cellspacing="0" border="0" align="center" width="800">
          <tr>
            <td class="menu" align="center">
              <strong>
              The status for the event listed above has changed.<br>
              <CFIF request.StatusCode NEQ "1">This quote will no longer be visible on the quote status page.</CFIF>
              <br>
              <CFIF IsDefined("URL.ReturnTo")>
                <input type="button" name="cancel" value="<CFOUTPUT>#request.CancelButton#</CFOUTPUT>" onClick="document.location.href='showQuotes.cfm?ClientID=<CFOUTPUT>#URL.ClientID#</CFOUTPUT>';">
              <CFELSEIF IsDefined("URL.ReturnClient")>
                <input type="button" name="cancel" value="<CFOUTPUT>#request.CancelButton#</CFOUTPUT>" onClick="returnToClient();">
              <CFELSE>
                <input type="button" name="cancel" value="<CFOUTPUT>#request.CancelButton#</CFOUTPUT>" onClick="goHome();">
              </CFIF>
              </strong>
            </td>
          </tr>
        </table>
      <cfcatch>Bad stuff happened</cfcatch>
    <CFTRY>
```
<small>* Actual code snippet from a 1500 line file that handled 1 actual function.</small>

<aside class="notes">I'd gone to CF.Objective this past spring and saw a couple of great Angular talks. They both walked through a demo app and did a good job explaining the framework. But something was missing. Talking with friends afterwards, we realized that people loved the talks, but they didn't know where to begin. See, most of us are stuck with code like that. We can't just rewrite everything as a front-end application. And all the demos assume you're doing just that. Yeah, yeah, ToDos...but what about my app? So I thought about what I'd want out of a presentation if I were still stuck maintaining code like that.
<br><br>
So I had to ask myself...what would you want?
</aside>



## I'd want:

<ul>
  <li class="fragment fade-in"> Quick Results</li>
  <li class="fragment fade-in"> Impress your boss</li>
  <li class="fragment fade-in"> Impress other geeks</li>
  <li class="fragment fade-in"> Resume fodder</li>
  <li class="fragment fade-in"> Learn to like JS a little bit and become one of the cool kids</li>
  <li class="fragment fade-in"> Fun/Feel like a genius</li>
</ul>

<aside class="notes">
  Quick results = I want to be making stuff happen like...tomorrow.  Ok, Monday.<br>
  Impress your boss = I want to justify being paid more money.<br>
  Impress other geeks = Geek cred is important.<br>
  Resume fodder = In case boss isn't impressed.<br>
  Learn to like JS a little bit and become one of the cool kids = I really *want* to like JS.<br>
  Fun/Feel like a genius = Remember when coding was fun? OK, coding is really a combination of feeling like a genius and feeling like a moron...sometimes at the same time. But it can still be fun.
</aside>



## Ben Nadel's Angular experience

<img src="images/ben-angular.png" />

<aside class="notes">
  I just had to include this graphic from Ben. It's my hope that I'll get you to at least the "Ok, that's pretty sweet" level.
</aside>




## Where are you now with JS?

<ul>
  <li class="fragment fade-in">Avoids Javascript like the plague</li>
  <li class="fragment fade-in">Enough jQuery to add it to your LinkedIn profile</li>
  <li class="fragment fade-in">A lot of jQuery and JS, but disorganized</li>
  <li class="fragment fade-in">A light framework (backbone.js)</li>
  <li class="fragment fade-in">A full framework (AngularJS, ember.js)</li>
</ul>

<aside class="notes">
  Show of hands.
</aside>




##You can't talk about Javascript without talking about jQuery
But let's just be honest...

<aside class="notes">
  Speaking of jQuery...
</aside>




## Nobody really liked this

```
function next(selector) {
    var $element = $(selector);

    return $element
        .children(":eq(0)")
        .add($element.next())
        .add($element.parents().filter(function() {
            return $(this).next().length > 0;
        }).next()).first();
}
```
<small class="fragment fade-in">Because jQuery is Imperative programming applied to the DOM</small>
<aside class="notes">
Other than Ray Camden maybe. 
<br><br>
And don't get me wrong, jQuery was a huge improvement over dealing with the DOM directly. But actually coding in jQuery was really not fun. Picture me sitting there with this face on...trying to traverse the DOM in my head and translating that into jQuery selectors...then binding to the right elements...and so on. Or looking at the HTML and trying to guess which element the jQuery was going to be affecting. IDs everywhere!
<br><br>
It's no fun because it's imperative programming applied to the DOM.
</aside>



## Geek Trivia

###Imperative vs. Declarative

<ul>
  <li>Imperative is explicitly the DOM what to do and how to do it.</li>
  <li>Declarative is describing what we want, and let the underlying systems figure out how to make it happen.</li>
</ul>

<aside class="notes">
  Not important to know this, but I like having terms for things. Besides, you've already done lots of both.
</aside>



##Look familiar?

  ```
  <cfloop query="myData">
    #name# #address# ...
  </cfloop>

  ```
<aside class="notes">
ColdFusion is very declarative. I, for one, have always loved the fact that I could look at the CFML mark-up and know exactly what each element was supposed to be doing. 
</aside>



##Angular is very declarative too.

```
  <div ng-repeat="item in myData">
    {{item.name}} {{item.address}}
  </div>
```
<aside class="notes">
  The Google guys may not like the comparison, but Angular actually does have a bit in common with ColdFusion. Angular has been described as "HTML extended". Well, guess what, CF has been doing that since 1995. What CF did with CFML tags, Angular is doing with directives. Angular includes a bunch of core directives, just like CF includes core tags. And both allow you to extend and make your own functionality, what CF calls custom tags, Angular calls...well, they still call them directives.
</aside>



## OK, nice slides...but...
> "Talk is cheap. Show me the code."

<small>~ Linus Torvalds</small>




## Demo 1
Bootstrapping a complete AngularJS Application

<code><pre>
&lt;!DOCTYPE html&gt;
&lt;html ng-app&gt;
    &lt;head&gt;
      &lt;title&gt;Adding AngularJS to Existing Apps - Basic App&lt;/title&gt;
        &lt;script src=&quot;/talks/common/angular/angular.min.js&quot;&gt;&lt;/script&gt;
    &lt;/head&gt;
    &nbsp;
    &lt;body&gt;
        &lt;h2 id=&quot;title&quot;&gt;Adding AngularJS to Existing Apps - Basic App&lt;/h2&gt;
        &lt;div&gt;
            Model me: &lt;input ng-model=&quot;my_model&quot;&gt;&lt;br&gt;
            {{my_model}}
        &lt;/div&gt;
    &lt;/body&gt;
&lt;/html&gt;
</pre></code>

<small><a href="demos/before/basic-app">Clicky-Clicky</a></small>

<aside class="notes">
  This is it. This is a fully-functioning, Angular app. OK, it's not an MVC app, it's just a MV app, but what it does is still pretty cool.
  <br><br>
  Ng-app is where it all begins. This is how Angular knows to attach itself to the DOM. You can use any HTML element. I'm using the html element here so that the entire page is under Angular control. But you can limit Angular to just a single div. In fact, you can even bootstrap multiple angular apps to different sections.
  <br><br>
  You'll also see another directive here: ng-model. What this directive does is tell Angular that this input is bound to the model "my_model". The awesomesauce of Angular is two-way data binding on any javascript object. In this case, it's just a string, but it could be an object or array as well. And anywhere that model is updated, it's reflected in other references to that object.
  <br><br>
  OK, that really didn't knock your hair back...let's try it with a controller.
</aside>



## Demo 2
With a controller

<code><pre>
&lt;!DOCTYPE html&gt;
&lt;html&gt;
    &lt;head&gt;
        &lt;title&gt;Adding AngularJS to Existing Apps - Demo 1&lt;/title&gt;
        &nbsp;
        &lt;!-- style counts --&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/normalize.css&quot;&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/main.css&quot;&gt;
        &nbsp;
        &lt;!-- core scripts --&gt;
        &lt;script src=&quot;/talks/common/angular/angular.min.js&quot;&gt;&lt;/script&gt;
        &nbsp;
        &lt;!-- app scripts --&gt;
        &lt;script&gt;
            'use strict';
            &nbsp;
            //App module.
            var app = angular.module('basic-app-module', []);
            &nbsp;
            //Controller - I control stuff
            app.controller('MainCtrl', function($scope) {
              &nbsp;
              $scope.title = &quot;Basic App Module&quot;;
              &nbsp;
            });
        &lt;/script&gt;
    &lt;/head&gt;
    &lt;body ng-app=&quot;basic-app-module&quot; ng-controller=&quot;MainCtrl&quot;&gt;
        &lt;h2 id=&quot;title&quot;&gt;Adding AngularJS to Existing Apps - {{title}}&lt;/h2&gt;
        &lt;div&gt;&lt;input ng-model=&quot;title&quot;&gt;&lt;/div&gt;
    &lt;/body&gt;
&lt;/html&gt;
</pre></code>

<small><a href="demos/after/basic-app-module">Clicky-Clicky</a></small>

<aside class="notes">
  In this one, we're declaring an app module. Angular is very module based, and this helps keep the code more organized into apps. 
  <br><br>
  We're also building our first controller. Controllers are the glue that ties everything together. You bind a controller to an HTML element with ng-controller. The next thing you might notice is the $scope prefix. $scope is a variable scope that is shared by the view and the controller. A lot of developers trip over $scope when first working with Angular, but after dealing with ColdFusion variable scopes, it felt fairly natural to me. Angular even has $rootScope, which is a scope shared across a whole application...you know, like Application scope.
  <br><br>
  You'll also notice that "$scope" was injected into the controller. Angular is big on dependency injection, and if you haven't done a lot with it before, it will feel a little cumbersome. But once you graduate to bigger apps and testing, you'll see how it simplifies everything.
</aside>



## Demo 3
Nothing ain't nothing without data

<code><pre>
&lt;!DOCTYPE html&gt;
&lt;html&gt;
    &lt;head&gt;
        &lt;title&gt;Adding AngularJS to Existing Apps - Simple With Data&lt;/title&gt;
        &nbsp;
        &lt;!-- style counts --&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/normalize.css&quot;&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/main.css&quot;&gt;
        &nbsp;
        &lt;!-- core scripts --&gt;
        &lt;script src=&quot;/talks/common/angular/angular.min.js&quot;&gt;&lt;/script&gt;
        &nbsp;
        &lt;!-- app scripts --&gt;
        &lt;script&gt;
            'use strict';
            &nbsp;
            //App module.
            var app = angular.module('basic-app-with-data', []);
            &nbsp;
            app.controller('MainCtrl', function($scope, $http) {
              &nbsp;
              $scope.title = &quot;Basic App with Data&quot;;
              &nbsp;
              // This really belongs in a service, but it's fine in the controller for now.
              $http.get('data.cfc?method=getBeers').then(function(results) {
                $scope.beers = results.data;
                console.log(results);
                console.log($scope.beers);
              });
              &nbsp;
            });
        &lt;/script&gt;
    &lt;/head&gt;
    &lt;body ng-app=&quot;basic-app-with-data&quot; ng-controller=&quot;MainCtrl&quot;&gt;
        &lt;h2 id=&quot;title&quot;&gt;Adding AngularJS to Existing Apps - {{title}}&lt;/h2&gt;
        &lt;div&gt;
            &lt;ul&gt;
                &lt;li ng-repeat=&quot;beer in beers | limitTo: 25&quot;&gt;{{beer.NAME}}&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/div&gt;
    &lt;/body&gt;
&lt;/html&gt;
</pre></code>

<small><a href="demos/after/basic-app-with-data">Clicky-Clicky</a></small>

<aside class="notes">
  When I look at demos, the first thing I want to do is talk to data. Unfortunately, most of the online demos don't do that because they can't host an actual demo app online. But I can.
  <br><br>
  Now, if your conventional app looks like the code sample I shared in the beginning, I have some bad news for you... But if you already have some data cfcs setup, most of your work is already done. Most angular demos show Angular talking to a nice, orderly REST interface. But you don't have to. So long as the returned data is JSON, angular doesn't care.
  <br><br>
  A lot of demos use $resource. There is nothing special about $resource except that it's optimized for REST interfaces and has some niceties built into it.
  <br><br>
  You can also use $http to pull back a flat json file. Angular doesn't care.
</aside>



## Demo 4
Put data access in a service

<code><pre>
&lt;!DOCTYPE html&gt;
&lt;html&gt;
    &lt;head&gt;
        &lt;title&gt;Adding AngularJS to Existing Apps - Simple With Data&lt;/title&gt;
        &nbsp;
        &lt;!-- style counts --&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/normalize.css&quot;&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/main.css&quot;&gt;
        &nbsp;
        &lt;!-- core scripts --&gt;
        &lt;script src=&quot;/talks/common/angular/angular.min.js&quot;&gt;&lt;/script&gt;
        &nbsp;
        &lt;!-- app scripts --&gt;
        &lt;script&gt;
            'use strict';
            &nbsp;
            //App module.
            var app = angular.module('basic-app-with-data-service', []);
            &nbsp;
            app.controller('MainCtrl', function($scope, $http, BeerSvc) {
            &nbsp;
              $scope.title = &quot;Demo with Data&quot;;
              &nbsp;
              BeerSvc.get().then(function(data) {
                $scope.beers = data;
              });
              &nbsp;
            });
            &nbsp;
            //App service
            app.service('BeerSvc', function($http) {
            &nbsp;
                this.get =  function() {
                    return $http.get('data.cfc?method=getBeers').then(function(response) {
                        return response.data;
                    });
                }
                &nbsp;
            });
            &nbsp;
        &lt;/script&gt;
        &nbsp;
    &lt;/head&gt;
    &lt;body ng-app=&quot;basic-app-with-data-service&quot; ng-controller=&quot;MainCtrl&quot;&gt;
        &lt;h2 id=&quot;title&quot;&gt;Adding AngularJS to Existing Apps - {{title}}&lt;/h2&gt;
        &lt;div&gt;
            &lt;ul&gt;
                &lt;li ng-repeat=&quot;beer in beers | limitTo: 25&quot;&gt;{{beer.NAME}}&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/div&gt;
    &lt;/body&gt;
&lt;/html&gt;
</pre></code>

<small><a href="demos/after/basic-app-with-data-service">Clicky-Clicky</a></small>

<aside class="notes">
  I'm not going to spend a lot of time on this, but I wanted to show a better way of doing the data handling. Services are shared singletons injected into controllers. Because they're singletons, they're also a good way to share data between controllers.
</aside>



##One more with a bigger service

<code><pre>
&lt;!DOCTYPE html&gt;
&lt;html&gt;
    &lt;head&gt;
        &lt;title&gt;Adding AngularJS to Existing Apps - Simple With Data&lt;/title&gt;
        &nbsp;
        &lt;!-- style counts --&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/normalize.css&quot;&gt;
        &lt;link rel=&quot;stylesheet&quot; href=&quot;/talks/css/main.css&quot;&gt;
        &nbsp;
        &lt;!-- core scripts --&gt;
        &lt;script src=&quot;/talks/common/angular/angular.min.js&quot;&gt;&lt;/script&gt;
        &nbsp;
        &lt;!-- app scripts --&gt;
        &lt;script&gt;
            'use strict';
            &nbsp;
            //App module.
            var app = angular.module('basic-app-with-data-service', []);
            &nbsp;
            app.controller('MainCtrl', function($scope, $http, BeerSvc) {
            &nbsp;
              $scope.title = &quot;Demo with Data&quot;;
              &nbsp;
              BeerSvc.get().then(function(data) {
                $scope.beers = data;
              });
              &nbsp;
              BeerSvc.count().then(function(data) {
                $scope.beerCount = data;
              });
              &nbsp;
            });
            &nbsp;
            //App service
            app.service('BeerSvc', function($http) {
                this.get =  function() {
                    return $http.get('data.cfc?method=getBeers').then(function(response) {
                        return response.data;
                    });
                }
                this.count = function() {
                    return $http.get('data.cfc?method=getBeerCount').then(function(response) {
                        return response.data;
                    });
                }
            });
        &lt;/script&gt;
        &nbsp;
    &lt;/head&gt;
    &lt;body ng-app=&quot;basic-app-with-data-service&quot; ng-controller=&quot;MainCtrl&quot;&gt;
        &lt;h2 id=&quot;title&quot;&gt;Adding AngularJS to Existing Apps - {{title}}&lt;/h2&gt;
        &lt;h4&gt;{{beerCount}} beers total.
        &lt;div&gt;
            &lt;ul&gt;
                &lt;li ng-repeat=&quot;beer in beers | limitTo: 25&quot;&gt;{{beer.NAME}}&lt;/li&gt;
            &lt;/ul&gt;
        &lt;/div&gt;
    &lt;/body&gt;
&lt;/html&gt;
</pre></code>

<aside class="notes">
  Just wanted to show a more expanded service. You can group functions together in a service by using the "this" namespace.
</aside>




##But what about a real app?

(My confession, I've never actually added AngularJS to an existing app until now.)



##"Real" Demo

<small><a href="demos/before/real-app">Clicky-Clicky</a></small>



## It's great when it works!

<img src="images/fire.jpg" />



##Now, a story

<img src="images/pointy-haired-boss.jpg" />

<small>Stop me if you've heard this one before</small>



##Rolling Demo

<small><a href="demos/before/real-app/sortable">Clicky-Clicky</a></small>



```
var app = angular.module('NCDevConTalk', []);
app.controller('TalkCtrl', function($scope) {
  $scope.status = 'done';
});
```

<br />

------

<br />

Slides: [Github Repo](https://github.com/Sharondio/talks/tree/master/2013/adding-angular-to-existing-apps)

<small>sharondio @ [twitter](http://twitter.com/sharondio) &amp; [Google+](https://plus.google.com/u/0/115487514031744604257/posts)</small>

<br />

------

Resources:
<small>

* [Docs] (http://angularjs.org) AngularJS
* [Tutorial] (http://docs.angularjs.org/tutorial) AngularJS Tutorial
* [Videos] (http://egghead.io) Egghead Videos
* [Videos] (http://www.youtube.com/user/angularjs) Angular Youtube Channel
* [Blog] (http://www.yearofmoo.com/) Year of Moo Blog


</small>