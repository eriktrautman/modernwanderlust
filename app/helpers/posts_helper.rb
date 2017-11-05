module PostsHelper

  # turns the image path into a full URL
  def paperclip_url_builder( image_path )
    protocol = "https://"
    subdomain = Rails.application.config.paperclip_defaults[:s3_credentials][:bucket]
    root = ".s3.amazonaws.com"
    protocol + subdomain + root + image_path
  end

end
# https://modernwanderlust.s3.amazonaws.com/posts/ironman/santa_rosa_tri_triumph.JPG
# image_tag post.header_image.url(:banner)
# paperclip_url_builder( post.header_image.path(:banner) )
