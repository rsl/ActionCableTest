App.items = App.cable.subscriptions.create "ItemsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    domId = "item_#{data.id}"
    $row = $(data.html)
    switch data.action
      when 'create'
        $('table.items').append $row
      when 'update'
        $("table.items tr##{domId}").replaceWith $row
      when 'destroy'
        $("table.items tr##{domId}").remove()
