class Post < ActiveRecord::Base

  validates_presence_of [:title, :body]
  validates :title, :uniqueness => { :message => "This title has been used before, choose another" }

  has_many :taggings
  has_many :tags, :through => :taggings

end
