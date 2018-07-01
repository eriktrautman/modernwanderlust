class Post < ActiveRecord::Base
  extend FriendlyId # to help with title slugging
  friendly_id :title, :use => [:slugged, :history]

  # Allow us to delete header images
  before_validation { header_image.clear if @delete_header_image }

  validates_presence_of [:title, :body, :slug]
  validates :title, :uniqueness => { :message => "This title has been used before, choose another" }

  has_attached_file :header_image, styles: {
              banner: '720x240#',   # used in large indexes
              bannerfull: '1600x800#', # used in post headers
              thumb: '118x100#',    # used in the file browser window
              square: '400x400#',   # used in compressed indexes
              squarelg: '800x800#',
              reduced: '800x800>'   # used atop post SHOW pages for faster DLs
            }
  validates_attachment_content_type :header_image, content_type: /\Aimage\/.*\z/

  has_many :taggings
  has_many :tags, :through => :taggings

  scope :order_rev_chron, -> { order('posts.created_at DESC') }
  scope :order_chron, -> { order('posts.created_at ASC') }
  scope :travel_only, -> { with_tag('Travel')}
  # Known issue: Used with .limit(), this behaves unpredictably
  #   because the limit is applied at multiple steps in the process
  scope :professional_only, -> { without_tags(['Travel']) }


  def delete_header_image
    @delete_header_image ||= false
  end

  def delete_header_image=(value)
    @delete_header_image  = !value.to_i.zero?
  end


  # Why does will_paginate blow up if the
  # order clause uses a hash?
  # Hell if I know.
  def self.with_tag(tag)
    Post.includes(:tags).where(['tags.name = ?', tag]).references(:tags)
  end

  # Blacklist the posts with a particular tag first
  # This avoids multiple-tag-overlap issues with typical SQL-based solutions
  def self.without_tags(tag_names)

    # First find the blacklisted Post IDs
    blacklisted_ids = Post.includes(:tags).where(['tags.name IN (?)', tag_names]).pluck(:id)

    #...then make sure to exclude them.
    Post.includes(:tags).where.not(id: blacklisted_ids).references(:tags)
  end


  def self.most_recent(count)
    Post.order(:created_at => :desc).limit(count)
  end

  def self.most_recent
    Post.order(created_at: :desc)
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

  # It's a professional post if it doesn't have the Travel tag
  # This may change over time.
  # To find not_professional? just negate with ! rather than
  # specifying Travel. For extensibility reasons.
  def professional?
    self.tags.none? { |tag| tag.name == "Travel" }
  end

  # It's a travel post if it has the Travel tag
  def travel?
    self.tags.any? { |tag| tag.name == "Travel" }
  end

  # When editing an existing post or creating a new
  # post, we replace the whole tags
  # collection with the existing or newly created tags
  def replace_or_build_tags(tags_string)
    tags = tags_string.split(",")
    self.tags = tags.map do |tag|
      # tag = Tag.find_or_create_by(name: tag.strip)
      tag = Tag.where('lower(name) = ?', tag.strip.downcase).first_or_create(name: tag.strip)
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
