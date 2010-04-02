require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module FaceB
  describe Api do
    describe "Default params" do
      subject { FaceB::Api.default_params }
      
      it { subject[:format].should == 'JSON' }
      it { subject[:v].should == '1.0' }
    end
    
    # Call
    describe "#call" do
      before(:each) do
        @session = FaceB.new('api-key', 'secret-key')
      end
      
      # Error Response
      context "When error" do
        before(:each) do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { 
            {"error_msg" => "error message", "error_code" => 100} 
          }
        end
        
        it "should get error nicely" do
          lambda {
            @session.call("facebook.method")
          }.should raise_error(FaceB::Api::Error, "Facebook error 100 : 'error message'")
        end
      end
      
      # Success Response with String
      context "When success with string response" do
        before(:each) do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { "data" }
          @response = @session.call("facebook.method")
        end
        
        subject { @response }
        
        it { should be_an_instance_of(FaceB::Api::Response) }
        its(:data) { should == 'data'}
      end
      
      # Success Response with Array with one Hash element
      context "When success with one Array response with one Hash element" do
        before(:each) do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { 
            [{'key1' => 'value1', 'key2' => 'value2'}]
          }
          @response = @session.call("facebook.method")
        end
        
        subject { @response }
        
        it { should be_an_instance_of(FaceB::Api::Response) }
        its(:data) { should == [{"key1"=>"value1", "key2"=>"value2"}] }
        its(:key1) { should == "value1" }
        its(:key2) { should == "value2" }
      end
      
      # Success Response one Hash element
      context "When success with one Hash response" do
        before(:each) do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { 
            {'key1' => 'value1', 'key2' => 'value2'}
          }
          @response = @session.call("facebook.method")
        end
        
        subject { @response }
        
        it { should be_an_instance_of(FaceB::Api::Response) }
        its(:data) { should == {"key1"=>"value1", "key2"=>"value2"} }
        its(:key1) { should == "value1" }
        its(:key2) { should == "value2" }
      end
      
      
      # Session Key
      context "With Session key" do
        before(:each) do
          mock.instance_of(FaceB::Session).secure_with_session_key!('session-key').once { 12345 }
          mock(@session).call('users.getLoggedInUser', :session_key => 'session-key') { FaceB::Api::Response.new(12345) }
          @session.secure_with_session_key!('session-key')
          @api = FaceB::Api.new(@session)
        end
                
        it "should pass the current session_key if param is true" do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL,  satisfy {|arg| arg[:body][:session_key] == "session-key"} ) {
            {"ok" => "ok"}
          }
          @api.call('method', :session_key => true)
        end
        
        it "should be able to averride the current session_key" do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL,  satisfy {|arg| arg[:body][:session_key] == "my-new-session-key"} ) {
            {"ok" => "ok"}
          }
          @api.call('method', :session_key => 'my-new-session-key')
        end
      end
      
    end
  end
end