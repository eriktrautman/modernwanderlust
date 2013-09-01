class Tag < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :taggings
  has_many :posts, :through => :taggings

  # We've got a problem now with dangling tags
  # with no associated posts, which can 
  # easily happen if a tag is removed from
  # a post

end
