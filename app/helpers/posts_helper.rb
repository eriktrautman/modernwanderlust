module PostsHelper

  # turns the image path into a full URL by building the base
  def paperclip_url_builder( image_path )
    protocol = "https://"
    subdomain = Rails.application.config.paperclip_defaults[:s3_credentials][:bucket]
    root = ".s3.amazonaws.com"
    protocol + subdomain + root + image_path
  end

end
