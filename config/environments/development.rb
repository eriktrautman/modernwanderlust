Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end


  # Devise specific configurations:
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  # Raises error for missing translations
  config.action_mailer.default_url_options = { :host => '0.0.0.0' }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true


  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker


  # config.action_controller.asset_host = 'https://modernwanderlust-dev.s3.amazonaws.com'
  # Paperclip for ckeditor
  # DEVELOPMENT
  config.paperclip_defaults = {
    :storage => :s3,

    # Example path: /modernwanderlust-dev/ckeditor/pictures/123/original/filename.jpg
    :url => ':s3_alias_url',
    :path => "/:class/:id/:style/:filename",
    # ---------------------

    # NOT SURE WHAT THIS WAS, GOT FROM INTERNET
    # :s3_host_alias => 's3-us-west-2.amazonaws.com/nutilesblog',

    # Normal Credentials
    :s3_credentials => {

      # put your host name here if needed
      :s3_host_name => "s3-us-west-2.amazonaws.com",
      :s3_region => "us-west-2",

      # NOTE: these lines are changed to use secrets.yml
      # from the examples (which use ENV vars instead)
      :bucket => Rails.application.secrets.s3_bucket_name,
      :access_key_id => Rails.application.secrets.aws_access_key_id,
      :secret_access_key => Rails.application.secrets.aws_secret_access_key
    }
  }
end
