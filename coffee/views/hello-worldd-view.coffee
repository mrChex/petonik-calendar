define [
  'views/base/view'
  'text!templates/hello-worldd.hbs'
], (View, template) ->
  'use strict'

  class HelloWorlddView extends View
    # Automatically render after initialize.
    autoRender: true
    className: 'hello-worldd'

    # Save the template string in a prototype property.
    # This is overwritten with the compiled template function.
    # In the end you might want to used precompiled templates.
    template: template
    template = null