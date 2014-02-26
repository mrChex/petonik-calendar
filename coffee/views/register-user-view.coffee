define [
  'views/base/view'
  'models/user'
  'text!templates/register-user.hbs'
], (View, UserModel, template) ->
  'use strict'

  class RegisterUserView extends View
    # Automatically render after initialize.
    autoRender: true
    className: 'register-user'

    # Save the template string in a prototype property.
    # This is overwritten with the compiled template function.
    # In the end you might want to used precompiled templates.
    template: template
    template = null

    events:
      "submit #registerUserForm": "registerUser"

    registerUser: (event)->
      url = $("#petonikUrl").val()
      $("#petonikUrl").prop 'disabled', true

      $("#registerUserSubmitButton").val 'Подождите...'

      user = new UserModel()
#        user_profile:

      console.log 'url is', url

      no
