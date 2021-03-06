(function() {
  var __slice = [].slice;

  define(['handlebars', 'chaplin', 'lib/utils'], function(Handlebars, Chaplin, utils) {
    'use strict';
    Handlebars.registerHelper('url', function() {
      var options, params, routeName, _i;
      routeName = arguments[0], params = 3 <= arguments.length ? __slice.call(arguments, 1, _i = arguments.length - 1) : (_i = 1, []), options = arguments[_i++];
      return utils.reverse(routeName, params);
    });
    return null;
  });

}).call(this);
