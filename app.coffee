express = require 'express'
app = express()

app.use '/bower_components', express.static "#{__dirname}/bower_components"
app.use '/js', express.static "#{__dirname}/js"
app.use '/css', express.static "#{__dirname}/css"

app.get '*', (req, res)->
  res.sendfile 'index.html'

app.listen 3000