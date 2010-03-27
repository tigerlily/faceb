require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module FaceB
  describe Api do
    it "should have default params" do
      FaceB::Api.default_params[:format].should == 'JSON'
      FaceB::Api.default_params[:v].should == '1.0'
    end
    
    # Session
    context "session" do
      before(:each) do
        FaceB.new('api-key', 'secret-key')
      end
      
      # General
      it "should get a response after an API call" do
        mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { 
          "data" 
        }
        
        response = FaceB.current_session.call("facebook.method", :param => 1)
        response.should be_an_instance_of(FaceB::Api::Response)
        response.data.should == 'data'
      end
      
      
      it "should get error nicely" do
        mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { 
          {"error_msg" => "error message", "error_code" => 100} 
        }
        
        lambda {
          response = FaceB.current_session.call("facebook.method", :param => 1)
        }.should raise_error(FaceB::Api::Error, "Facebook error 100 : 'error message'")
        #response = Facebook.current_session.call("facebook.method", :param => 1)
        #response.error[:code].should == 100
        #response.error[:msg].should == "error message"
      end
      
      # Session Key
      describe "Session key" do
        before(:each) do
          mock.instance_of(FaceB::Session).get_user_id.once { "12345" }
          session = FaceB::Session.new('api-key', 'secret-key', 'session-key')
          session.session_key.should == 'session-key'
          session.user_uid.should == '12345'
          
          @api = FaceB::Api.new(session)
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
      
      
      # Response Retriever
      describe "Response Retriever" do
        it "should retrieve value in a array with 1 hash element" do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { 
            [ {'key1' => 'value1', 'key2' => 'value2'} ]
          }
          response = FaceB.current_session.call("facebook.method", :param => 1)
          response.key1.should == 'value1'
          response.key2.should == 'value2'
        end
        
        it "should retrieve value in a hash element" do
          mock(FaceB::Api).post(FaceB::Api::API_SERVER_URL, is_a(Hash)) { 
            {'key1' => 'value1', 'key2' => 'value2'}
          }
          response = FaceB.current_session.call("facebook.method", :param => 1)
          response.key1.should == 'value1'
          response.key2.should == 'value2'
        end
      end
      
    end
  end
end