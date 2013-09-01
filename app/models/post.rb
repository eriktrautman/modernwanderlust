class Post < ActiveRecord::Base

  validates_presence_of [:title, :body]
  validates :title, :uniqueness => { :message => "This title has been used before, choose another" }

  has_many :taggings
  has_many :tags, :through => :taggings

  def self.with_tag(tag)
    Post.includes(:tags).where(['tags.name = ?', tag]).references(:tags).order(:created_at => :desc)
  end

  # When editing an existing post or creating a new
  # post, we replace the whole tags
  # collection with the existing or newly created tags
  def replace_or_build_tags(tags_string)
    tags = tags_string.split(",")
    self.tags = tags.map do |tag|
      tag = Tag.find_or_create_by_name(tag.strip)
    end
  end

  def tag_list
    self.tags.map(&:name).join(", ")
  end

end
