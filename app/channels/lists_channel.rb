class ListsChannel < ApplicationCable::Channel
  def subscribed
    puts '>> Subscribed to ListsChannel'
    stream_from "lists_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts '<< Unsubscribed from ListsChannel'
  end
end
