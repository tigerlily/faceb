require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Facebook
  describe Api do
    it "should have default params" do
      Facebook::Api.default_params[:format].should == 'JSON'
      Facebook::Api.default_params[:v].should == '1.0'
    end
    
    context "session" do
      before(:each) do
        Facebook.new('api-key', 'secret-key')
      end
      
      it "should get a response after an API call" do
        mock(Facebook::Api).post(Facebook::Api::API_SERVER_URL, is_a(Hash)) { 
          "data" 
        }
        
        response = Facebook.current_session.call("facebook.method", :param => 1)
        response.should be_an_instance_of(Facebook::Api::Response)
        response.data.should == 'data'
      end
      
      
      it "should get error nicely" do
        mock(Facebook::Api).post(Facebook::Api::API_SERVER_URL, is_a(Hash)) { 
          {"error_msg" => "error message", "error_code" => 100} 
        }
        
        response = Facebook.current_session.call("facebook.method", :param => 1)
        response.error[:code].should == 100
        response.error[:msg].should == "error message"
      end
      
      describe "Response Retriever" do
        it "should retrieve value in a array with 1 hash element" do
          mock(Facebook::Api).post(Facebook::Api::API_SERVER_URL, is_a(Hash)) { 
            [ {'key1' => 'value1', 'key2' => 'value2'} ]
          }
          response = Facebook.current_session.call("facebook.method", :param => 1)
          response.key1.should == 'value1'
          response.key2.should == 'value2'
        end
        
        it "should retrieve value in a hash element" do
          mock(Facebook::Api).post(Facebook::Api::API_SERVER_URL, is_a(Hash)) { 
            {'key1' => 'value1', 'key2' => 'value2'}
          }
          response = Facebook.current_session.call("facebook.method", :param => 1)
          response.key1.should == 'value1'
          response.key2.should == 'value2'
        end
      end
      
    end
  end
end