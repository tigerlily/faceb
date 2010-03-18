require 'facebook/rails/configuration'
require 'facebook/rails/railtie'

module Facebook
  class << self
    def config
      Facebook::Configuration.config
    end    
  end
end