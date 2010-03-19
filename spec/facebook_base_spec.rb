require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Facebook do
  # New
  describe "#new" do
    it "should create a new Facebook session" do
      Facebook.new('api-key', 'secret-key')
      Facebook.current_session.should_not be_nil
      Facebook.current_session.should be_an_instance_of(Facebook::Session)
    end
  end
  
  # Call
  describe "#call" do
    it "should be able to call the api without create a session before" do
      mock.instance_of(Facebook::Session).call('method', :params => 1) { "response" }
      Facebook.call('api-key', 'secret-key', 'method', :params => 1).should == "response"
      Facebook.current_session.should be_nil
    end
  end
end