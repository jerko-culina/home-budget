source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3"

gem "bcrypt", "~> 3.1.7"
gem 'blueprinter'
gem "bootsnap", require: false
gem 'factory_bot'
gem 'money-rails'
gem "pg", "~> 1.3"
gem "puma", "~> 5.0"
gem "sprockets-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker'
  gem 'rspec-rails', '~> 5.1.2'
  gem 'pry'
end

group :development do
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
