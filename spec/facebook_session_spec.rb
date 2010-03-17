require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Facebook
  describe Session do
    
    

    # Create session
    context "create session" do
      before(:each) do
        @session = Facebook::Session.create('api-key', 'secret-key')
      end
      
      it "should have a current session" do
        Facebook::Session.current.should_not be_nil
        Facebook::Session.current.should be_an_instance_of(Facebook::Session)
        Facebook::Session.current.should == @session
      end
      
      it "should be able to reset the current session" do
        Facebook::Session.current.should_not be_nil
        Facebook::Session.reset!
        Facebook::Session.current.should be_nil
      end
    end
    
    # New session
    context "new session" do
      before(:each) do
        @session = Facebook::Session.new('api-key', 'secret-key')
      end
      
      it "should not have a current session" do
        Facebook::Session.current.should be_nil
      end
      
      # Session key
      describe "session_key" do
        it "should be able to initialize a session with a session key" do
          session = Facebook::Session.new('api-key', 'secret-key', 'session-key')
          session.session_key.should == 'session-key'
        end
      end
      
      # Api
      describe "Api" do
        it "Call API method" do
          mock(Facebook::Api).post(Facebook::Api::API_SERVER_URL, is_a(Hash)) { "data" }
          response = @session.call("method", :param => 1)
          response.should be_an_instance_of(Facebook::Api::Response)
        end
      end
      
      # Confirguation
      describe "#configuration" do  
        it "should be able to configure a new session" do
          @session.api_key.should     == 'api-key'
          @session.secret_key.should  == 'secret-key'
        end
      end
    end    
  end
end
