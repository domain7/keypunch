class Group < ActiveRecord::Base
  has_paper_trail
  has_ancestry
  attr_accessible :title, :ancestry
  has_many :entity_groups
  has_many :entities, :through => :entity_groups

  validates :title, :presence => true
end
