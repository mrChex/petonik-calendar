define [
  'controllers/base/controller'
  'views/register-user-view'
], (Controller, RegisterUserView) ->
  'use strict'

  class RegisterController extends Controller

    user: (params) ->
      @view = new RegisterUserView region: 'main'