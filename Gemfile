# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'aws-sdk-s3', require: false
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'chart-js-rails', '~> 0.1.4'
gem 'coffee-rails', '~> 4.2'
gem 'dotenv-rails'
gem 'faker'
gem 'font-awesome-rails'
gem 'google-cloud-vision'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '>= 3.12.4'
gem 'rack'
gem 'rails', '~> 5.2.2'
gem 'rails-i18n'
gem 'ransack'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
  gem 'rubocop'
  gem 'spring-commands-rspec'
end

group :developmemt do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
end

group :production do
  gem 'pg', '>= 0.18', '< 2.0'
  gem 'rails_12factor'
end
