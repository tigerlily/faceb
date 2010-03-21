$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'facebook'
require 'spec'
require 'spec/autorun'

require 'rails_spec_helper' if ENV["FACEBOOK_TEST"] == 'rails'

# Stop all requests
require 'fakeweb'
FakeWeb.allow_net_connect = false

# Use RR for mock
require 'rr'

Spec::Runner.configure do |config|
  config.mock_with :rr
  
  # Reset the session after each example
  config.prepend_before(:each) do
    Facebook::Session.reset!
  end
end
