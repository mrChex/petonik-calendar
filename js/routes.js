(function() {
  define(function() {
    'use strict';
    return function(match) {
      return match('register/user', 'register#user');
    };
  });

}).call(this);
