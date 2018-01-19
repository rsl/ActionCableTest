$(document).on 'turbolinks:load', ->
  $itemsTable = $('table.items')
  if $itemsTable.length
    channelIdentifier = {
      channel: 'ItemsChannel', list_id: $itemsTable.data('listId')
    }
    App.items = App.cable.subscriptions.create channelIdentifier,
      connected: ->
        # Called when the subscription is ready for use on the server
        console.log "connected: ItemsChannel [list_id: #{$itemsTable.data('listId')}]"

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log "disconnected: ItemsChannel [list_id: #{$itemsTable.data('listId')}]"

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
          when 'list_destroy'
            alert('This list has been deleted. Redirecting to lists index.')
            location.href = $itemsTable.data('redirectTo')
  else if App.items
    App.items.unsubscribe()
    # Remove reference as well
    delete App.items
  console.log App
