if Rails.version >= "3.0"
  require 'faceb/rails/railtie'
  require 'faceb/rails/generators'
elsif Rails.version >= "2.3"
  require 'faceb/rails/rails_23_init'
else
  raise "Sorry, but FaceB need Rails 2.3 or later"
end

require 'faceb/rails/base'
require 'faceb/rails/controller'
