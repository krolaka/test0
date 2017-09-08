$(document).ready ->

  getMessages = ->
    user_id =
    $.ajax '/messages/load_messages',
      type: 'GET'
      dataType: 'html'
      success: (data)->
          $('.messages_list').html(data)
    return

  setInterval ->
    getMessages()
  , 1000*60*10

  $('.refresh-button').on 'click', ->
    getMessages()
    return