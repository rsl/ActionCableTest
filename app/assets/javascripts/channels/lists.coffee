$(document).on 'turbolinks:load', ->
  if $('table.lists').length
    # Do we need to force a new connection?
    App.lists ||= App.cable.subscriptions.create "ListsChannel",
      connected: ->
        # Called when the subscription is ready for use on the server
        console.log 'connected: ListsChannel'

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log 'disconnected: ListsChannel'

      received: (data) ->
        domId = "list_#{data.id}"
        $row = $(data.html)
        switch data.action
          when 'create'
            $('table.lists').append $row
          when 'update'
            $("table.lists tr##{domId}").replaceWith $row
          when 'destroy'
            $("table.lists tr##{domId}").remove()
  else if App.lists
    App.lists.unsubscribe()
    # Remove reference as well
    delete App.lists
  console.log App
