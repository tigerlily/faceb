module Facebook
  module Rails
    module Controller
      
      def self.included(controller)
        controller.extend(ClassMethods)
      end
      
      def create_facebook_session
        Facebook::Session.create(Facebook.config.api_key, Facebook.config.secret_key, env['facebook.session_key'])
      end
      
      # Return true if request comes from a Facebook canvas
      def in_canvas?
        !!env['facebook.in_canvas']
      end
      
      # Class methods
      module ClassMethods
        def method_name
          
        end
      end
    end
  end
end

