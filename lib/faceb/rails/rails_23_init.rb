Rails.configuration.after_initialize do
  require 'rack/facebook'

  # Load the FaceB config file
  begin
    @facebook_config = FaceB::Configuration.load_config_file(FaceB.config_file_path, ::Rails.env)
  rescue Errno::ENOENT
    puts "Warning : config/faceb.yml is not present. Maybe you should called rake faceb:init"
  rescue
    puts "Error during load FaceB config file."
  end

  # Load Rack-Facebook as a middleware    
  Rails.configuration.middleware.use Rack::Facebook, {
    :application_secret => @facebook_config.secret_key, 
    :api_key => @facebook_config.api_key
  }
  
  # Registered FBML request type
  Mime::Type.register "text/html", :fbml
end
