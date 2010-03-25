require 'yaml'

module FaceB
  class Configuration
    def initialize(config)
      @config = config
    end
    
    def method_missing(name, *args)
      @config[name.to_s]
    end
    
    
    ##
    # Load a config file to create a new instance of Configuration
    # 
    # @param [String] file File path
    # @param [String] environment The Rails environment
    def self.load_config_file(file, environment)
      @config = self.new(YAML.load_file(file)[environment])
    end
    
    ##
    # Return the current configuration instance
    # 
    # @return [Facebook::Configuration] The current configuration instance
    def self.config
      @config
    end
  end
end