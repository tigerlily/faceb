require 'rails/generators'

module FaceB
  class ConfigGenerator < Rails::Generators::Base
    class_option :api_key,    :type => :string, :aliases => '-a', :desc => "Facebook API key"
    class_option :secret_key, :type => :string, :aliases => '-s', :desc => "Facebook secret key"
    
    def create_config_file
      template "faceb.yml", "config/faceb.yml"
    end
    
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end
  end
end