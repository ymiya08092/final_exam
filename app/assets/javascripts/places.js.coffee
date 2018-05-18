# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  if !window.google

    script = document.createElement('script')
    script.type = 'text/javascript';
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.expkey=AIzaSyDE9c9EOFd9YnXyEJDrhD-S1dojx1tzQOc&callback=triggerMap'
    document.body.appendChild(script)

  else
    triggerMap()

window.triggerMap = ->
   # --- show --- #
  mapCanvas = $('.map-show-canvas')
  if mapCanvas.length && mapCanvas.attr('data-latitude')

    MapHelper.showMap(mapCanvas.get(0),
      {
        mapHeight:      300,
        mapLat:         mapCanvas.attr('data-latitude'),
        mapLng:         mapCanvas.attr('data-longitude'),
        zoom:           10
        #scaleControl: ,
        #scrollwheel: ,
        #showMarker: ,
        #draggable: ,
      }
    )
    
    # --- new/edit --- #
  if $('.map-search-button').length

    MapHelper.searchShowMap($('.map-canvas').get(0),
      {
        mapHeight:      300,
        trigger:        $('.map-search-button'),
        addressInput:   $('.address'), #could be multiple
        latInput:       $('#place_latitude'),
        lngInput:       $('#place_longitude'),
        zoom:           10
        #scaleControl: ,
        #scrollwheel: ,
        #showMarker: ,
        #draggable: ,
        afterShow: ->
          console.log "Map is displayed."
      }
    )
    
    # --- index --- #
  if $('.map-index').length
    $.ajax(
      type: 'GET',
      url: '/places.json',
      # data: { if you need }
    ).done( (data) ->
      if data.length
        MapHelper.showMapWithMarkers($('.map-index').get(0),
          {
            mapHeight:    400,
            mapLat:       data[0].latitude,  #center
            mapLng:       data[0].longitude, #center
            zoom:         2,
            showMarker:   false,
            draggable:    false,
            controller:   'places',
            titleField:   'name'
          }, data)
    )

    

# For turbolinks
$(document).ready(ready)
$(document).on 'page:load', ready