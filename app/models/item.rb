class Item < ApplicationRecord
  belongs_to :list

  validates :name, presence: true

  after_commit :update_item_lists

private

  def update_item_lists
    action = 'create' if saved_change_to_id?
    action = 'destroy' if destroyed?
    action ||= 'update'
    UpdateItemListsJob.perform_later(id, list_id, action)
  end
end
