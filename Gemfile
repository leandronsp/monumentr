source 'https://rubygems.org'

gem 'rails'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'carrierwave'
gem 'mini_magick'
gem 'settingslogic'
gem 'pg'
gem 'pg_search'

# Heroku
gem 'rails_12factor', group: :production

gem 'puma'

group :development, :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'pry-byebug'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'database_cleaner'
  gem "rails-controller-testing", :git => "https://github.com/rails/rails-controller-testing"
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'simplecov'
  gem 'machinist'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end
