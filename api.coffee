http = require 'http'


request = (path, callback)->
  console.log 'make request', path
  options =
    hostname: "petonik.com"
    path: path
    method: 'GET'
    headers:
      'X-Requested-With': 'XMLHttpRequest'

  req = http.request options, (res)->
    res.setEncoding 'utf8'
    response_data = ""

    res.on 'data', (chunk)-> response_data += chunk
    res.on 'end', ->
      console.log 'request ended', path
      callback JSON.parse response_data

  req.end()

exports.get_user = (user_id, callback)-> request "/#{user_id}/", callback
exports.get_user_pets = (user_id, callback)-> request "/#{user_id}/pets/", callback
exports.get_user_pet = (user_id, pet_id, callback)-> request "/#{user_id}/pet/#{pet_id}", callback

#exports.get_user 'chex', (u)-> console.log 'u is', u