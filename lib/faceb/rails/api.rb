module FaceB
  Api.class_eval do
    def call_with_rails(method, params = {})
      ActiveSupport::Notifications.instrument("faceb.api", :method => method, :params => params) do
        call_without_rails(method, params)
      end
    end

    alias_method :call_without_rails, :call
    alias_method :call, :call_with_rails
  end
  
  class LogSubscriber < Rails::LogSubscriber
    def api(event)
      debug color("FaceB call method '#{event.payload[:method]}' with #{event.payload[:params].inspect} in (#{event.duration})", :blue, true)
    end
  end
end

# Add log for API method call
Rails::LogSubscriber.add :faceb, FaceB::LogSubscriber.new