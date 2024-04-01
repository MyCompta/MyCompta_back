# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors'

gem 'devise', '~> 4.9', '>= 4.9.3'
gem 'devise-jwt', '~> 0.11.0'
gem 'faker', '~> 3.2'

group :development, :test do
  gem 'brakeman', '~> 3.3', '>= 3.3.2'
  gem 'bundle-audit', '~> 0.1.0'
  gem 'database_consistency', '~> 1.7', '>= 1.7.23', require: false
  gem 'factory_bot_rails'
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
  gem 'rails_best_practices', '~> 1.23', '>= 1.23.2'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 6.1', '>= 6.1.1', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'shoulda-matchers', '~> 6.1'
  gem 'table_print', '~> 1.5', '>= 1.5.7'
end
gem 'dockerfile-rails', '>= 1.6', group: :development
