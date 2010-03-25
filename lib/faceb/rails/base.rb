require 'faceb/rails/configuration'
require 'faceb/rails/railtie'

module FaceB
  class << self
    
    ##
    # Return the current Facebook Rails configuration
    # 
    # @return [FaceB::Configuration] the current Facebook Rails configuration
    def config
      FaceB::Configuration.config
    end    
  end
end