class EntityUser < ActiveRecord::Base
  belongs_to :entity
  belongs_to :user
  attr_accessible :entity_id, :user_id

  validates :entity_id, presence: true
  validates :user_id, presence: true
end
