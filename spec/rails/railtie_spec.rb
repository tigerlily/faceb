require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Rails app initialization" do
  before(:each) do
    Dummy::Application.initialize!
  end
  
  it "should load facebook config file" do
    Facebook.config.should_not be_nil
    Facebook.config.api_key.should == 'rails-api-key'
    Facebook.config.secret_key.should == 'rails-secret-key'
  end
  
  it "should add Rack-Facebook as a middleware" do
    Dummy::Application.config.middleware.should include(Rack::Facebook)
  end
  
  it "should add FBML request type" do
    mime_type = Mime::Type.lookup(:fbml)
    mime_type.should_not be_nil
    mime_type.should be_an_instance_of(Mime::Type)
  end
end
