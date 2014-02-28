define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  # The application object.
  # Choose a meaningful name for your application.
  class Application extends Chaplin.Application
    title: 'Chaplin example application'
    start: ->
      console.log 'Application start method was called'

      VK.init =>
        console.log 'VK application was inited'
        super