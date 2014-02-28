define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class User extends Chaplin.Model
    url: '/api/user'
    defaults:
      first_name: 'FirstName'
      avatar_photo:
        _avatar_for: ''
        user_id: 0
        name: ''
        original_url: ''
        big_url: ''
        medium_url: ''
        preview_url: ''
        has_big: no
        has_medium: no
        has_preview: no
        likes: []
      id: no
      profile_url: ''

    # initialize: (attributes, options) ->
    #   super
    #   console.debug 'HelloWorld#initialize'