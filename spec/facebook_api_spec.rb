require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Facebook
  describe Api do
    it "should have default params" do
      Facebook::Api.default_params[:format].should == 'JSON'
      Facebook::Api.default_params[:v].should == '1.0'
    end
    
    context "session" do
      before(:each) do
        @session = Facebook.new('api-key', 'secret-key')
      end

      it "should get a response after an API call" do
        Facebook::Api.should_receive(:post).and_return("data")
        response = @session.call("facebook.method", :param => 1)
        response.should be_an_instance_of(Facebook::Api::Response)
        response.data.should == 'data'
      end
      
      it "should get error nicely" do
        Facebook::Api.should_receive(:post).and_return({"error_msg" => "error message", "error_code" => 100})
        response = @session.call("facebook.method", :param => 1)
        response.error[:code].should == 100
        response.error[:msg].should == "error message"
      end
    end
    
  end
end