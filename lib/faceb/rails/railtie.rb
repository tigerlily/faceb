require 'rails'
require 'faceb'
require 'rack/facebook'

module FaceB
  class Railtie < ::Rails::Railtie
    railtie_name :facebook

    # Load the FaceB config file
    initializer "faceb.load_config_file" do |app|
      begin
        @facebook_config = FaceB::Configuration.load_config_file(FaceB.config_file_path, ::Rails.env)
      rescue Errno::ENOENT
        puts "Warning : config/faceb.yml is not present. Maybe you should called ./script/rails generate face_b"
      rescue
        puts "Error during load FaceB config file."
      end
    end
    
    # Load Rack-Facebook as a middleware    
    initializer "faceb.add_middleware" do |app|
      app.config.middleware.use Rack::Facebook, {
        :application_secret => @facebook_config.secret_key, 
        :api_key => @facebook_config.api_key
      } if @facebook_config
    end
    
     # Registered FBML request type
     initializer "faceb.add_fbml_request_type" do |app|
       Mime::Type.register "text/html", :fbml
     end
    
    # load Facebook Specific tasks
    rake_tasks do
      load "faceb/rails/tasks/faceb.tasks"
      load "faceb/rails/tasks/tunnel.tasks"
    end
  end
end