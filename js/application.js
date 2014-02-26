(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['chaplin'], function(Chaplin) {
    'use strict';
    var Application;
    return Application = (function(_super) {
      __extends(Application, _super);

      function Application() {
        return Application.__super__.constructor.apply(this, arguments);
      }

      Application.prototype.title = 'Chaplin example application';

      Application.prototype.start = function() {
        console.log('Application start method was called');
        return Application.__super__.start.apply(this, arguments);
      };

      return Application;

    })(Chaplin.Application);
  });

}).call(this);
