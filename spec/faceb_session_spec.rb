require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module FaceB
  describe Session do
    
    # Dynamic API call
    context "When call API" do
      before(:each) do
        @session = FaceB::Session.new('api-key', 'secret-key')
      end
      
      it "should be able to call an API method" do
        mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { "data" }
        response = @session.call('scope.api_method', :param1 => 'value1')
        response.should be_an_instance_of(FaceB::Api::Response)
        response.data.should == "data"
      end
      
      it "should be able to dynamically build an API method" do
        mock(@session).call('scope.api_method', :param1 => 'value1')
        response = @session.scope.api_method(:param1 => 'value1')
      end
    end
    
    # Create session
    context "When create session" do
      before(:each) do
        @session = FaceB::Session.create('api-key', 'secret-key')
      end
      
      subject { @session }
      
      its(:api_key)     { should == 'api-key' }
      its(:secret_key)  { should == 'secret-key' }

      it { should be_an_instance_of(FaceB::Session) }
      
      it "should set session as the current session" do
        FaceB::Session.current.should == @session
      end
      
      it "should be able to reset the current session by class method" do
        FaceB::Session.reset!
        FaceB::Session.current.should be_nil
      end
      
      it "should be able to reset the current session by instance method" do
        FaceB::Session.current.reset!
        FaceB::Session.current.should be_nil
      end
    end
    
    # New session
    context "When instanciate new session" do
      before(:each) do
        @session = FaceB::Session.new('api-key', 'secret-key')
      end
      
      subject { @session }
      
      its(:api_key)     { should == 'api-key' }
      its(:secret_key)  { should == 'secret-key' }

      it { should be_an_instance_of(FaceB::Session) }
      
      it "should not have persistent session" do
        FaceB::Session.current.should be_nil
      end
      
      # Session key
      context "With session key" do
        before(:each) do
          mock.instance_of(FaceB::Session).call('users.getLoggedInUser', :session_key => 'session-key') { FaceB::Api::Response.new(12345) }
          @session = FaceB::Session.new('api-key', 'secret-key', 'session-key')
        end
        
        subject { @session }
        
        its(:api_key)     { should == 'api-key' }
        its(:secret_key)  { should == 'secret-key' }
        its(:session_key)       { should == 'session-key' }
        its(:user_facebook_uid) { should == 12345 }
        
        it { should be_an_instance_of(FaceB::Session) }
      end
    end    
  end
end
