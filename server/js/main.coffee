AudioAnalyser = require './AudioAnalyser'

analyser = new AudioAnalyser()

canvas = null
ctx = null
w = null
h = null


$ ->
  # socketUri = location.protocol + '//' + location.host + '/'
  # socket = io(socketUri)

  # setTimeout(->
  #   console.log 'emit!'
  #   socket.emit 'sample_emit',{state:'ashikawa'}
  # ,2000)


  # addEvent
  $(window).on 'resize',resizeHandler
  $('#startBtn').on 'click',startAnalyser


startAnalyser = ()->
  setup()  
  render()

  $('#startBtn').remove()

setup = ()->
  canvas = $('#canvas')[0]
  ctx = canvas.getContext('2d')
  
  analyser.start()
  resizeHandler()
  

render = ()->
  ctx.clearRect(0,0,w,h)
  ctx.fillStyle = '#000022'
  ctx.fillRect(0,0,w,h)

  data = analyser.getData()

  ctx.fillStyle = '#f3c80f'
  borderW = w/data.length*2
  for i in [0...data.length]
    ctx.fillRect(i*borderW, 0, borderW, data[i]*2);
        # //下部の描画
    ctx.fillRect(i*borderW, h, borderW, -data[i]*2);

  requestAnimationFrame(render)


resizeHandler = ()->
  w = canvas.width = $(window).width()
  h = canvas.height = $(window).height()


