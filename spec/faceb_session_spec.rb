require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module FaceB
  describe Session do
    
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
        its(:facebook_user_uid) { should == 12345 }
        
        it { should be_an_instance_of(FaceB::Session) }
      end
      
      describe "#login_url" do
        it "should be able to build login url for application" do
          subject.login_url.should == "http://www.facebook.com/login.php?v=1.0&api_key=#{subject.api_key}"
        end
        
        it "should be able to build login url for application with next param" do
          subject.login_url(:next => 'http://www.nexturl.com').should =~ %r{http://www.facebook.com/login.php\?(.*)next=http%3A%2F%2Fwww.nexturl.com}
        end
      end
      
      describe "#secure_with_session_key!" do
        it "should set facebook_user_uid" do
          mock(subject).call('users.getLoggedInUser', :session_key => 'bad session key') { FaceB::Api::Response.new(123456) }
          subject.secure_with_session_key!("bad session key")
          subject.facebook_user_uid.should == 123456
        end
        
        it "should raise an error if bad session key" do
          mock(subject).call('users.getLoggedInUser', :session_key => 'bad session key') { 
            FaceB::Api::Response.new({"error_code" => 102, "error_msg" => 'Session key invalid or no longer valid'}) 
          }
          lambda {
            subject.secure_with_session_key!("bad session key")
          }.should raise_error(FaceB::Api::Error, "Facebook error 102 : 'Session key invalid or no longer valid'")
        end
      end
      
      
      # API call
      describe "#call" do
        it "should be able to call an API method" do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { "data" }
          response = subject.call('scope.api_method', :param1 => 'value1')
          response.should be_an_instance_of(FaceB::Api::Response)
          response.data.should == "data"
        end

        it "should be able to dynamically build an API method" do
          mock(subject).call('scope.api_method', :param1 => 'value1')
          response = subject.scope.api_method(:param1 => 'value1')
        end
      end
      
    end    
  end
end
