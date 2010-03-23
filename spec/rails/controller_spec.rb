require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Dummy Controller
Dummy::Application.initialize!
class MockController < ApplicationController
  include Facebook::Rails::Controller
  
  ensure_authenticated_to_facebook :only => :action1
  
  def self.before_filters
    _process_action_callbacks.select { |c| c.kind == :before }
  end
  
  def action1;end
  def action2;end
end

# MockController
describe MockController do  
  describe "ClassMethods" do
    it "should include before_filter 'set_facebook_request_format'" do
      filters = MockController.before_filters.map! { |c| c.raw_filter }
      filters.should include(:set_facebook_request_format)
    end

    it "should include ensure_authenticated_to_facebook filter only for action1" do
      filter = MockController.before_filters.find {|f| f.raw_filter == :ensure_authenticated_to_facebook}
      filter.options[:only].should == :action1
    end
  end
  
  
  describe "InstanceMethods" do
    xit "should aa" do
      get :action1
    end
  end  
end
