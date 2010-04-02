require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FaceB do
  
  describe "#current_session" do
    before(:each) do
      @session = FaceB.new('api-key', 'secret-key')
    end
    
    subject { FaceB.current_session }
    
    it { should be_an_instance_of(FaceB::Session) }
    it { should == @session }
    
    its(:api_key)     { should == 'api-key' }
    its(:secret_key)  { should == 'secret-key' }
  end
  
  # New
  describe "#new" do
    before(:each) do
      @session = FaceB.new('api-key', 'secret-key')
    end
    
    subject { @session }
    
    its(:api_key)     { should == 'api-key' }
    its(:secret_key)  { should == 'secret-key' }
    
    it "should be able to reset the current session" do
      FaceB::Session.reset!
      FaceB.current_session.should be_nil
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