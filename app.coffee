express = require 'express'
http = require 'http'
https = require 'https'  # http://silas.sewell.org/blog/2010/06/03/node-js-https-ssl-server-example/
app = express()
fs = require "fs"

options =
  key: fs.readFileSync('keys/privatekey.pem')
  cert: fs.readFileSync('keys/certificate.pem')

app.use '/bower_components', express.static "#{__dirname}/bower_components"
app.use '/js', express.static "#{__dirname}/js"
app.use '/css', express.static "#{__dirname}/css"

app.get '*', (req, res)-> res.sendfile 'index.html'

#http.createServer(app).listen 3000
https.createServer(options, app).listen 3443