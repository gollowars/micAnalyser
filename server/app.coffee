koa = require 'koa.io'
logger = require 'koa-logger'
route = require 'koa-route'
serve = require 'koa-static'
views = require 'co-views'
path = require 'path'

app = module.exports = koa()
app.use logger()
render = views(__dirname + '/views')
app.use serve('./public')


# routing
app.use route.get '/', (next) ->
  @body = yield render('index.jade')

# socket
app.io.use (next) ->
  console.log 'connected'
  yield next
  console.log 'disconnect'


nsSample = app.io.of '/'
nsSample.on 'connection', (socket) ->
  console.log 'connection'

  socket.on 'sample_emit',(data)->
    console.log data



app.listen 3000