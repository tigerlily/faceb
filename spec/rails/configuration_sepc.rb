require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module FaceB
  module Rails
    describe Configuration do
      it "should be included in FaceB" do
        FaceB.should respond_to(:config)
      end
    end
  end
end
