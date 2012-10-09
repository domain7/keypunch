class PasswordHistory < ActiveRecord::Base
  attr_accessible :uniqueable_id, :uniqueable_type, :encrypted_password, :uniqueable
  belongs_to :uniqueable, :polymorphic => true
end
