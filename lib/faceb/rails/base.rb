require 'faceb/rails/configuration'

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
    
    # Change method signature with default api_key and secret_key
    def new_with_rails(api_key = FaceB.config.api_key, secret_key = FaceB.config.secret_key, session_key = nil)
      new_without_rails(api_key, secret_key, session_key)
    end
    
    alias_method :new_without_rails, :new
    alias_method :new, :new_with_rails
  end
end