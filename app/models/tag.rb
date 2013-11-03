class Tag < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :taggings
  has_many :posts, :through => :taggings

  scope :by_posts,
    select("tags.*, count(posts.id) AS posts_count")
      .joins(:posts)
      .group("tags.id")
      .order("posts_count DESC")


  # We've got a problem now with dangling tags
  # with no associated posts, which can 
  # easily happen if a tag is removed from
  # a post

end
