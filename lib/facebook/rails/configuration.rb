require 'yaml'

module Facebook
  class Configuration
    def initialize(config)
      @config = config
    end
    
    def method_missing(name, *args)
      @config[name.to_s]
    end
    
    
    
    def self.load_config_file(file, environment)
      @config = self.new(YAML.load_file(file)[environment])
    end
    
    def self.config
      @config
    end
  end
end