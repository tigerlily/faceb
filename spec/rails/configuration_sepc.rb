require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Facebook
  module Rails
    describe Configuration do
      it "should be included in Facebook" do
        Facebook.should respond_to(:config)
      end
    end
  end
end
