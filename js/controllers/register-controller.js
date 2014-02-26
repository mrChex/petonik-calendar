(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['controllers/base/controller', 'views/register-user-view'], function(Controller, RegisterUserView) {
    'use strict';
    var RegisterController;
    return RegisterController = (function(_super) {
      __extends(RegisterController, _super);

      function RegisterController() {
        return RegisterController.__super__.constructor.apply(this, arguments);
      }

      RegisterController.prototype.user = function(params) {
        return this.view = new RegisterUserView({
          region: 'main'
        });
      };

      return RegisterController;

    })(Controller);
  });

}).call(this);
