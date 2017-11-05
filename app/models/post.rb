class Post < ActiveRecord::Base
  extend FriendlyId # to help with title slugging
  friendly_id :title, :use => [:slugged, :history]

  validates_presence_of [:title, :body, :slug]
  validates :title, :uniqueness => { :message => "This title has been used before, choose another" }

  has_attached_file :header_image, styles: {
              banner: '720x240#',   # used in large indexes
              thumb: '118x100#',    # used in the file browser window
              square: '400x400#',   # used in compressed indexes
              squarelg: '800x800#',
            }
  validates_attachment_content_type :header_image, content_type: /\Aimage\/.*\z/

  has_many :taggings
  has_many :tags, :through => :taggings

  scope :order_rev_chron, -> { order('posts.created_at DESC') }
  scope :order_chron, -> { order('posts.created_at ASC') }

  # Why does will_paginate blow up if the
  # order clause uses a hash?
  # Hell if I know.
  def self.with_tag(tag)
    Post.includes(:tags).where(['tags.name = ?', tag]).references(:tags).order("posts.created_at desc")
  end

  def self.most_recent(count)
    Post.order(:created_at => :desc).limit(count)
  end

  # Get back the count of posts for each month/year
  # combination.  Currently not sorted (very very very
  # very very annoying to try and implement that)
  def self.archives
    Post.group("date_trunc('month',created_at)").count
  end

  # Use the query string to
  # filter the index by year and month individually
  def self.by_archive_date(month, year)
    start = Time.new(year,month)
    finish = start + 1.month
    Post.where(["created_at >= ? AND created_at < ?", start, finish]).order(:created_at => :desc)
  end

  # When editing an existing post or creating a new
  # post, we replace the whole tags
  # collection with the existing or newly created tags
  def replace_or_build_tags(tags_string)
    tags = tags_string.split(",")
    self.tags = tags.map do |tag|
      tag = Tag.find_or_create_by(name: tag.strip)
    end
  end

  def tag_list
    self.tags.map(&:name).join(", ")
  end

  def next
    # Must add that second because AR rounds off the seconds when
    # building the query so it's not precise!!!

    Post.where("posts.created_at > ?", self.created_at + 1.second).order(:created_at => :asc).limit(1).first
  end

  def prev
    # Must take off the second because AR rounds off the seconds when
    # building the query so it's not precise!!!

    Post.where("posts.created_at < ?", self.created_at - 1.second).order(:created_at => :desc).limit(1).first
  end

  # def should_generate_new_friendly_id?
  #   true #new_record?
  # end

end
