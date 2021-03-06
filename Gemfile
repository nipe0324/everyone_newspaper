source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Use Twitter Bootstarp for design
gem 'bootstrap-sass'
# For pagination
gem 'will_paginate'

# Use Facor to creating data fo test
gem 'faker'

# Use masonry for layout of newspaper page
gem 'masonry-rails'

# Use paperclip to post a file to an article.
gem 'paperclip'

group :development, :test do
	# Use sqlite3 as the database for Active Record
	gem 'sqlite3'
	# Use RSpec for tests
	gem 'rspec-rails'
	# User Guard for auto tests of rspec and cucumber
	gem 'guard-rspec'
	gem 'guard-cucumber'
	# Use Guard for auto reload browser
	gem 'guard-livereload'
	# User spork for speed up of tests
	gem 'spork-rails'
	gem 'guard-spork'
	gem 'childprocess'
end

group :test do
	gem 'selenium-webdriver' # be depended by Capybara
	gem 'capybara'					 # Describe tests like English
	gem 'factory_girl_rails' # for test to create models easily
	gem 'cucumber-rails', :require => false # Use Cucumber for tests
	gem 'database_cleaner', github: 'bmabey/database_cleaner' # for cucumber

  # For guard
  gem 'rb-fsevent', :require => false
  gem 'terminal-notifier-guard' # Mac OS Xの通知センターを利用可能

  # Coverage
  gem 'simplecov', :require => false
end

group :production do
	gem 'pg'							# use postgresql on Heroku
	gem 'rails_12factor'	# run rails4 on Heroku
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

