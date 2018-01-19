class ItemsChannel < ApplicationCable::Channel
  def subscribed
    # Can raise if params[:list_id] is missing
    puts params
    puts '>> Subscribed to from ItemsChannel'
    stream_from "items_channel_list_#{params[:list_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts '<< Unsubscribed from ItemsChannel'
  end
end
