define [
  "underscore"
  "chaplin"
  "lib/websocket_handler"
  "lib/view_helpers"
  "templates/preloader"
], (_, Chaplin, WebSocketHandler, viewHelpers, preloader) ->
  "use strict"

  class View extends Chaplin.View

    _(@prototype).extend WebSocketHandler

    # Could be overloaded in subclasses
    templateData: {}
    # Used for rendering with params
    _templateData2: {}

    dispose: ->
      @closeWebSocket()
      super

    render: (params = {}) ->
      @_templateData2 = params
      super

    getTemplateData: ->
      data = super
      templateData = if typeof @templateData is "function"
        @templateData()
      else
        @templateData
      _(data).extend viewHelpers, templateData, @_templateData2

    getTemplateFunction: ->
      @template

    fetchWithPreloader: ->
      return if @$(".preloader").length
      @$el.append viewHelpers.renderTemplate preloader
      d = @model.fetch()
      d.always =>
        @$(".preloader").remove()
