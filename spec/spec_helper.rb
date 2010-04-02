$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'faceb'
require 'spec'
require 'spec/autorun'

require 'rails_spec_helper' if ENV["FACEB_TEST"] == 'rails'


# Stop all requests
require 'fakeweb'
FakeWeb.allow_net_connect = false

# Use RR for mock
require 'rr'

Spec::Runner.configure do |config|
  config.mock_with :rr
  
  # Reset the session after each example
  config.prepend_before(:each) do
    FaceB::Session.reset!
  end
end

TMP_DIR = File.join(File.dirname(__FILE__), 'tmp')