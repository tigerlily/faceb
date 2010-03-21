puts "\n==> Run Rails tests"
require 'rails'

# Rails app
ENV["RAILS_ENV"] = "test"
require File.expand_path('../rails_app/config/application', __FILE__)
