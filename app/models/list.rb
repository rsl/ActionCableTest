class List < ApplicationRecord
  has_many :items

  after_commit :update_list_lists

private

  def update_list_lists
    action = 'create' if saved_change_to_id?
    action = 'destroy' if destroyed?
    action ||= 'update'
    UpdateListListsJob.perform_later(id, action)
  end
end
