define [
  'controllers/base/controller'
  'models/hello-world'
  'views/hello-world-view'
  'views/hello-worldd-view'
], (Controller, HelloWorld, HelloWorldView, HelloWorlddView) ->
  'use strict'

  class HelloController extends Controller
    show: (params) ->
      @model = new HelloWorld()
      @view = new HelloWorldView model: @model, region: 'main'

    showd: (params) ->
      @model = new HelloWorld()
      @view = new HelloWorlddView model: @model, region: 'main'