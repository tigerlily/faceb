require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FaceB do
  # New
  describe "#new" do
    it "should create a new Facebook session" do
      FaceB.new('api-key', 'secret-key')
      FaceB.current_session.should_not be_nil
      FaceB.current_session.should be_an_instance_of(FaceB::Session)
    end
  end
  
  # Call
  describe "#call" do
    it "should be able to call the api without create a session before" do
      mock.instance_of(FaceB::Session).call('method', :params => 1) { "response" }
      FaceB.call('api-key', 'secret-key', 'method', :params => 1).should == "response"
      FaceB.current_session.should be_nil
    end
  end
  
  it "should not be included in Facebook" do
    FaceB.should_not respond_to(:config)
  end
end