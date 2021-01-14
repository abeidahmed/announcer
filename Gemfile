source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 6.1.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.4", require: false
# gem "redis", "~> 4.0"
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem 'shoulda-matchers', '~> 4.5'
  gem 'rspec-rails', '~> 4.0', '>= 4.0.2'
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
