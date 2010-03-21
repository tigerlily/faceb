module Facebook
  module Rails
    module Controller
      
      def self.included(controller)
        controller.extend(ClassMethods)
        controller.before_filter :set_facebook_request_format
      end
      
      def create_facebook_session
        Facebook::Session.create(Facebook.config.api_key, Facebook.config.secret_key, env['facebook.session_key'])
      end
      
      # Return true if request comes from a Facebook canvas
      def in_canvas?
        !!env['facebook.in_canvas']
      end
      
      # Return true if request comes from an Facebook iframe
      def in_iframe?
        !!env["facebook.in_iframe"]
      end
      
      # Set the request format 
      def set_facebook_request_format
        if in_canvas? && !in_iframe?
          request.format = :fbml
        end
      end
      
      # Class methods
      module ClassMethods
        def ensure_authenticated_to_facebook(options = {})
          before_filter :create_facebook_session, options
        end
      end
    end
  end
end

