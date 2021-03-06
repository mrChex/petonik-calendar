(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['views/base/view', 'text!templates/site.hbs'], function(View, template) {
    'use strict';
    var SiteView;
    return SiteView = (function(_super) {
      __extends(SiteView, _super);

      function SiteView() {
        return SiteView.__super__.constructor.apply(this, arguments);
      }

      SiteView.prototype.container = 'body';

      SiteView.prototype.id = 'site-container';

      SiteView.prototype.regions = {
        main: '#main-container'
      };

      SiteView.prototype.template = template;

      template = null;

      return SiteView;

    })(View);
  });

}).call(this);
