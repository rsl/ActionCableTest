class UpdateItemListsJob < ApplicationJob
  attr_accessor :id, :action

  def perform(id, list_id, action)
    self.id = id
    self.action = action
    channel = "items_channel_list_#{list_id}"
    ActionCable.server.broadcast(channel, payload)
    UpdateListListsJob.perform_later(list_id, 'update')
  end

private

  def payload
    {
      id: id,
      html: html,
      action: action
    }
  end

  def html
    item = Item.find_by(id: id)
    return unless item
    ItemsController.render('_item', layout: false,
      locals: {item: item.decorate})
  end
end
