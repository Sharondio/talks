# Angular Filters
### Ng-Conf Jauary 2013

Sharon DiOrio &bull; [@sharondio](https://twitter.com/sharondio)

<aside class="notes"></aside>



## 
### Filters seemed like Magic
<img src="images/fire.jpg">

<aside class="notes"></aside>



<img src="images/pointy-haired-boss.jpg">

<aside class="notes"></aside>



## Reasons most people pick technologies/frameworks

<ul>
  <li class="fragment fade-in">How much does it cost?</li>
  <li class="fragment fade-in">Does it fit into our current infrastructure?</li>
  <li class="fragment fade-in">Are developers trained in it?</li>
  <li class="fragment fade-in">Is it stable?</li>
  <li class="fragment fade-in">Is it Microsoft/Google/Java?</li>
</ul>

<aside class="notes"></aside>



## Reasons I pick technologies/frameworks

<ul>
  <li class="fragment fade-in">Quick Results</li>
  <li class="fragment fade-in">Impress your boss</li>
  <li class="fragment fade-in">Impress other geeks</li>
  <li class="fragment fade-in">Resume fodder</li>
  <li class="fragment fade-in">Fun/Feel like a genius</li>
</ul>

<aside class="notes">
  Quick results = I want to be making stuff happen like...tomorrow.  Ok, Monday.<br>
  Impress your boss = I want to justify being paid more money.<br>
  Impress other geeks = Geek cred is important.<br>
  Resume fodder = In case boss isn't impressed.<br>
  Fun/Feel like a genius = Remember when coding was fun? OK, coding is really a combination of feeling like a genius and feeling like a moron...sometimes at the same time. But it can still be fun.
</aside>



## My first App

<!-- consider embedding demo -->
<a href="demos/first-app/">DEMO</a>

<aside class="notes"></aside>



## How it works



## Built-in Filters



## String Filter
<!-- code sample -->



## Filter: Filter (Array Each Filter)
<!-- checkboxes demo -->


## Custom Filter
<!-- code sample -->


## Testing Filters
<!-- code sample -->


## Chaining Filters
<!-- code sample -->


## Performance of Filters



## Don't Use Filters



## Filters are Still Magical
<!-- charts demo -->



```
var app = angular.module('NgConfTalk', []);
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