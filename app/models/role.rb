class Role < ActiveRecord::Base
  cattr_reader :role_options

  # specify the type of roles that can be used
=begin
  @@role_options = {
    admin: 'admin',
    user: 'user',
    development: 'development',
    design: 'design'
  }
=end

  attr_accessible :name
  has_and_belongs_to_many :users
  has_many :entity_roles
  has_many :entities, :through => :entity_roles

  validates :name, presence: true
  #validates :name, presence: true, inclusion: { :in => @@role_options.values }
end
