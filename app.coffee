express = require 'express'
http = require 'http'
https = require 'https'  # http://silas.sewell.org/blog/2010/06/03/node-js-https-ssl-server-example/
fs = require "fs"

app = express()
app.use express.bodyParser()

api = require './api'

options =
  key: fs.readFileSync('keys/privatekey.pem')
  cert: fs.readFileSync('keys/certificate.pem')

app.use '/bower_components', express.static "#{__dirname}/bower_components"
app.use '/js', express.static "#{__dirname}/js"
app.use '/css', express.static "#{__dirname}/css"

app.get '*', (req, res)-> res.sendfile 'index.html'

app.use '/api/user', (req, res)->
  api.get_user "#{req.body['profile_url']}", (user)-> res.send user['current_user']

#http.createServer(app).listen 3000
https.createServer(options, app).listen 3443