class Item < ApplicationRecord
  validates :name, presence: true

  after_commit :update_item_lists

private

  def update_item_lists
    action = 'create' if saved_change_to_id?
    action = 'destroy' if destroyed?
    action ||= 'update'
    UpdateItemListsJob.perform_later(id, action)
  end
end
