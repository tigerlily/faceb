require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module FaceB
  describe Session do
    
    # Create session
    context "create session" do
      before(:each) do
        @session = FaceB::Session.create('api-key', 'secret-key')
      end
      
      it "should have a current session" do
        FaceB::Session.current.should_not be_nil
        FaceB::Session.current.should be_an_instance_of(FaceB::Session)
        FaceB::Session.current.should == @session
      end
      
      it "should be able to reset the current session" do
        FaceB::Session.current.should_not be_nil
        FaceB::Session.reset!
        FaceB::Session.current.should be_nil
      end
    end
    
    # New session
    context "new session" do
      before(:each) do
        @session = FaceB::Session.new('api-key', 'secret-key')
      end
      
      it "should not have a current session" do
        FaceB::Session.current.should be_nil
      end
      
      # Session key
      describe "session_key" do
        it "should be able to initialize a session with a session key" do
          mock.instance_of(FaceB::Session).call('users.getLoggedInUser', :session_key => 'session-key') { FaceB::Api::Response.new("12345") }
          session = FaceB::Session.new('api-key', 'secret-key', 'session-key')
          session.session_key.should == 'session-key'
          session.user_uid.should == '12345'
        end
      end
      
      # Api
      describe "Api" do
        it "Call API method" do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { "data" }
          response = @session.call("method", :param => 1)
          response.should be_an_instance_of(FaceB::Api::Response)
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