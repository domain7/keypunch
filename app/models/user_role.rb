class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  attr_accessible :user_id, :role_id

  validates :user_id, presence: true
  validates :role_id, presence: true
end
