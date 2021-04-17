source 'https://rubygems.org'
ruby '2.6.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',                    '5.1.7'  # Mar 2019. Rails 5.2 breaks Devize and Simple Form
gem 'pg',                       '~> 0.21.0'
gem 'simple_form',              '~> 3.5.0'
gem 'will_paginate-bootstrap',  '~> 1.0.1'
gem 'rails_12factor'  # for heroku asset compilation
gem 'devise',                   '~> 4.3.0' # for authentication of the admin user
gem 'friendly_id',              '>= 5.0.0.rc2' # for the post title slugs
gem 'redcarpet',                '~> 3.4.0' # for markdown rendering
gem 'newrelic_rpm',             '~> 4.5.0.337' # for newrelic uptime tracking and no-idle pinging
gem 'figaro'
gem 'rb-readline'               # Why? Goddamnit if I know but couldn't find the right readline version before.
gem 'puma',                      '~>5.2.2'
gem 'ckeditor',                 '~> 4.2.4'  # The blog post creation editor.
gem 'paperclip',                '~> 6.0'    # NOTE: DEPRECATED! See https://github.com/kreeti/kt-paperclip instead.
gem 'aws-sdk-s3',               '~> 1.0'
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f' # because mimemagic was yanked

# Use SCSS for stylesheets
gem 'sass-rails',               '~> 5.0.6'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier',                 '~> 3.2.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails',             '~> 4.2.2'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails',             '~> 4.3.1'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks',               '~> 5.0.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder',                 '~> 2.7.0'

group :development do
  gem 'listen'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails'
  gem 'capybara'
  # Use a debugger
  gem 'byebug'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development
