require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Facebook
  describe Session do
    before(:each) do
      @session = Facebook.new('api-key', 'secret-key')
    end
    
    it "Call API method" do
      Facebook::Api.should_receive(:post).and_return("data")
      response = @session.call("Users.getInfo", :uid => 123, :fields => 'first_name')
      response.should be_an_instance_of(Facebook::Api::Response)
    end
    
    describe "#configuration" do  
      it "should be able to configure a new session" do
        @session.api_key.should     == 'api-key'
        @session.secret_key.should  == 'secret-key'
      end
      
      it "should be able to retrieve the current session" do
        Facebook.current_session.should == @session
      end
    end
  end
end
