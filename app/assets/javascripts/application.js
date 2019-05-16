// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

function tokenize(input) {
  function ShuntStack() {
    this.ops = [];
    this.top = 0;
    this.length = this.top;
    this.push = function(el) { this.ops[this.top++] = el };
    this.pop = function() { this.ops[--this.top] };
    this.peek = function() { this.ops[this.top - 1] };
  }

  var s = new ShuntStack();
  var known_ops = ["AND","IN"];
  var precedence = { "AND":2, "IN":1 };
  var token;
  var o1, o2;
  var output = [];

  var tokens = input.split(" ");
  for (var i = 0; i < tokens.length; i++) {
    token = tokens[i];
    if (!known_ops.includes(token)) {
      output.push(token);
      continue;
    }
    o1 = token;
    o2 = s.peek();
    while (known_ops.includes(o2) && precedence[o1] <= precedence[o2]) {
      output.push(o2);
      s.pop();
      o2 = s.peek();
    }
    s.push(o1);
  }
  return output.concat(s.ops.reverse());
}

console.log("included!");
