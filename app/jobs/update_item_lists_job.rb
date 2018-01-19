class UpdateItemListsJob < ApplicationJob
  attr_accessor :id, :action

  def perform(id, action)
    self.id = id
    self.action = action
    update_item_list
  end

private

  def update_item_list
    ActionCable.server.broadcast "items_channel", payload
  end

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
