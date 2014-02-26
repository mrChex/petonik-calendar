(function() {
  define(function() {
    'use strict';
    return function(match) {
      match('', 'hello#show');
      return match('test', 'hello#showd');
    };
  });

}).call(this);
