require 'rails/generators'

module FaceB
  class FbConnectGenerator < Rails::Generators::Base
    class_option :ssl, :type => :boolean, :desc => "SSL support"
    
    def create_xd_receiver_file
      file = options.ssl ? 'xd_receiver_ssl.html' : 'xd_receiver.html'
      template file, "public/#{file}"
    end
    
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end
  end
end