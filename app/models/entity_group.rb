class EntityGroup < ActiveRecord::Base
  belongs_to :entity
  belongs_to :group
  attr_accessible :entity_id, :group_id

  validates :entity_id, presence: true
  validates :group_id, presence: true
end
