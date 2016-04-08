module.exports = class AudioAnalyser
  constructor: ()->

    @SupportAudioContext = null
    @mediaStreamSource = null

    @init()
    
  init:()->
    try
      SupportedAudioContext = window.AudioContext || window.webkitAudioContext
    catch e
      throw new Error('Web Audio API is not supported.')
      alert 'Web Audio API is not supported.'


    # console.log SupportedAudioContext
    @context = new SupportedAudioContext()
    @filter = @context.createBiquadFilter()
    # @filter.type = 0
    # @filter.frequency.value = 440
    @analyserNode = @context.createAnalyser()
    # @analyserNode.fftSize = 128

  initMic:()->
    navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
    navigator.getUserMedia { audio: true },@connectMicToOutput,@errorMic


  connectMicToOutput:(mic)=>
    @mediaStreamSource = @context.createMediaStreamSource(mic)
    @mediaStreamSource.connect(@filter)
    @filter.connect(@analyserNode);
    @analyserNode.connect(@context.destination)

    console.log @analyserNode

  errorMic:(e)->
    console.log e

  # API
  getData:()->
    data = new Uint8Array(@analyserNode.frequencyBinCount)
    @analyserNode.getByteFrequencyData(data)
    return data

  start:()->
    @initMic()

  stop:()->
    @mediaStreamSource.disconnect(context.distination);
    @mediaStreamSource = null
