require 'faceb/rails/configuration'
require 'faceb/rails/railtie'
#require 'faceb/rails/generators/faceb_generator'
require 'faceb/rails/generators'

module FaceB
  class << self
    
    ##
    # Return FaceB config file path
    # 
    # @return [String] config file path
    def config_file_path
      File.join(::Rails.root, 'config', 'faceb.yml')
    end
    
    ##
    # Return the current Facebook Rails configuration
    # 
    # @return [FaceB::Configuration] the current Facebook Rails configuration
    def config
      FaceB::Configuration.config
    end    
  end
end