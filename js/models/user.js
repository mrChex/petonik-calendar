(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['chaplin'], function(Chaplin) {
    'use strict';
    var User;
    return User = (function(_super) {
      __extends(User, _super);

      function User() {
        return User.__super__.constructor.apply(this, arguments);
      }

      User.prototype.url = '/api/user';

      User.prototype.defaults = {
        first_name: 'FirstName',
        avatar_photo: {
          _avatar_for: '',
          user_id: 0,
          name: '',
          original_url: '',
          big_url: '',
          medium_url: '',
          preview_url: '',
          has_big: false,
          has_medium: false,
          has_preview: false,
          likes: []
        },
        id: false,
        profile_url: ''
      };

      return User;

    })(Chaplin.Model);
  });

}).call(this);
