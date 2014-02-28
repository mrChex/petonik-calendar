(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['views/base/view', 'models/user', 'text!templates/register-user.hbs'], function(View, UserModel, template) {
    'use strict';
    var RegisterUserView;
    return RegisterUserView = (function(_super) {
      __extends(RegisterUserView, _super);

      function RegisterUserView() {
        return RegisterUserView.__super__.constructor.apply(this, arguments);
      }

      RegisterUserView.prototype.autoRender = true;

      RegisterUserView.prototype.className = 'register-user';

      RegisterUserView.prototype.template = template;

      template = null;

      RegisterUserView.prototype.events = {
        "submit #registerUserForm": "registerUser"
      };

      RegisterUserView.prototype.registerUser = function(event) {
        var url, user;
        url = $("#petonikUrl").val();
        $("#petonikUrl").prop('disabled', true);
        $("#registerUserSubmitButton").val('Подождите...');
        user = new UserModel({
          profile_url: url.replace("http://", '').replace('www.petonik.com/', '').replace('petonik.com/', '').split('/')[0]
        });
        console.log('user is', user);
        user.save({
          success: (function(_this) {
            return function(data) {
              return console.log('success', data);
            };
          })(this)
        });
        return false;
      };

      return RegisterUserView;

    })(View);
  });

}).call(this);
