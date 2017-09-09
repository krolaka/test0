#= require jquery
#= require rails-ujs
#= require turbolinks
#= require twitter/bootstrap
#= require_tree .

$(document).on "turbolinks:load", ->
  getCount = ->
    $.ajax '/messages/count_messages',
      type: 'GET'
      dataType: 'json'
      success: (data)->
        if data.count > 0
          $('span.found-messages').removeClass 'hidden'
          $('span.notfound-messages').addClass 'hidden'
          $('span.count_messages').html(data.count)
        else
          $('span.found-messages').addClass 'hidden'
          $('span.notfound-messages').removeClass 'hidden'
    return

  getCount()
  setInterval ->
    getCount()
  , 10000
