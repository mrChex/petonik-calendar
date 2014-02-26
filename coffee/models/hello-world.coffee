define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class HelloWorld extends Chaplin.Model
    defaults:
      message: 'Hello World!'

    # initialize: (attributes, options) ->
    #   super
    #   console.debug 'HelloWorld#initialize'