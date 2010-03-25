require 'facebook/rails/configuration'
require 'facebook/rails/railtie'

module Facebook
  class << self
    
    ##
    # Return the current Facebook Rails configuration
    # 
    # @return [Facebook::Configuration] the current Facebook Rails configuration
    def config
      Facebook::Configuration.config
    end    
  end
end