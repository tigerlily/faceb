require 'rails'
require 'facebook'
require 'rack/facebook'

module Facebook
  class Railtie < ::Rails::Railtie
    railtie_name :facebook

    # Load the Facebook config file
    initializer "facebook.load_config_file" do |app|
      @facebook_config = Facebook::Configuration.load_config_file(File.join(::Rails.root, 'config', 'facebook.yml'), ::Rails.env)
    end
    
    # Load Rack-Facebook as a middleware    
    initializer "facebook.add_middleware" do |app|
      app.config.middleware.use Rack::Facebook, {
        :application_secret => @facebook_config.secret_key, 
        :api_key => @facebook_config.api_key
      }
    end
    
     # Registered FBML request type
     initializer "facebook.add_fbml_request_type" do |app|
       Mime::Type.register "text/html", :fbml
     end
    
    # load Facebook Specific tasks
    rake_tasks do
      load "facebook/rails/tasks/facebook.tasks"
    end
  end
end