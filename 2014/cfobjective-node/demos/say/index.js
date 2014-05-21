  var say = require('say'),
  sys = require('sys');

  var codeMonkey = "" + 
    "Code Monkey get up get coffee," + 
    "Code Monkey go to job," + 
    "Code Monkey have boring meeting," + 
    "With boring manager Rob," + 
    "Rob say Code Monkey very diligent," + 
    "But his output stink," + 
    "His code not functional or elegant," + 
    "What do Code Monkey think?";

  // no callback, fire and forget
  say.speak('Alex', codeMonkey);