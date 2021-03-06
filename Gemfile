source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# JQuery chosen plugin. Makes select boxes better.
gem 'chosen-rails'

# New version of Sufia would depend on redlock already so this can be removed
# when updating Sufia. See comments in app/services/sufia/lock_manager.rb
gem 'redlock', '~> 0.1.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#gem 'sufia', '6.3.0'
# Sorting and collection memorisation fix isn't in 6.3.0 so pin to a more recent commit
gem 'sufia', github: 'projecthydra/sufia', ref: 'f838704'
gem 'kaminari', github: 'jcoyne/kaminari', branch: 'sufia'
gem 'devise'
gem 'devise-guests', '~> 0.3'
gem 'devise_ldap_authenticatable'
gem 'hydra-role-management'
gem 'mysql2'
gem 'clamav'
gem 'redis-session-store'
gem 'rubyzip'

# Use our branch of Active-Fedora and RSolr until upstream PRs are merged.
# See https://github.com/rsolr/rsolr/pull/116 and https://github.com/projecthydra/active_fedora/pull/960
gem 'active-fedora', github: 'durham-university/active_fedora', branch: 'configurable_handlers'
gem 'rsolr', github: 'durham-university/rsolr', branch: 'configurable_handlers'
gem 'active_fedora-noid', '>= 1.0.3'

# Get hydra-editor from github until some fixes are pushed to gem repositories.
# Remove this line when a new version is released.
gem 'hydra-editor', github: 'projecthydra/hydra-editor', ref: '04f24d5'

# Fix mini_magick at the latest 3.x version
# After that there are incompatibilities with Ruby 2.0.0p598, used on CentOS 7
# See https://github.com/minimagick/minimagick/issues/278
gem 'mini_magick', '3.8.1'

#gem 'qa', '~> 0.5.0'

group :development, :test do
  gem 'puma'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  
  # View template debugging. Toggle in browser with ctrl+shift+x or cmd+shift+x
  gem 'xray-rails'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rspec-rails'
  gem 'jettywrapper'

#  gem 'simplecov', require: false
#  gem 'coveralls', require: false
  gem 'database_cleaner', require: false
  gem 'capybara'

  gem 'factory_girl_rails'
end

group :test_server do
  gem 'web-console', '~> 2.0'
end
