(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['views/base/view', 'text!templates/hello-worldd.hbs'], function(View, template) {
    'use strict';
    var HelloWorlddView;
    return HelloWorlddView = (function(_super) {
      __extends(HelloWorlddView, _super);

      function HelloWorlddView() {
        return HelloWorlddView.__super__.constructor.apply(this, arguments);
      }

      HelloWorlddView.prototype.autoRender = true;

      HelloWorlddView.prototype.className = 'hello-worldd';

      HelloWorlddView.prototype.template = template;

      template = null;

      return HelloWorlddView;

    })(View);
  });

}).call(this);
