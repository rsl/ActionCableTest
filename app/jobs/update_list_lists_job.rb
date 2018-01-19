class UpdateListListsJob < ApplicationJob
  attr_accessor :id, :action

  def perform(id, action)
    self.id = id
    self.action = action
    ActionCable.server.broadcast('lists_channel', payload)
    if action == 'destroy'
      UpdateItemListsJob.perform_later(nil, id, 'list_destroy')
    end
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
    list = List.find_by(id: id)
    return unless list
    ListsController.render('_list', layout: false,
      locals: {list: list.decorate})
  end
end
