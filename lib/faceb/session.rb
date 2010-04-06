module FaceB
  class Session
    attr_reader :api_key, :secret_key, :session_key, :user_facebook_uid
    
    def self.create(api_key, secret_key, session_key = nil)
      @current_session = self.new(api_key, secret_key, session_key) unless defined?(@current_session) && !!@current_session
      @current_session
    end
    
    def self.current
      @current_session
    end
    
    def self.reset!
      @current_session = nil
    end
    
    def reset!
      self.class.reset!
    end
    
    def initialize(api_key, secret_key, session_key = nil)
      @api_key            = api_key
      @secret_key         = secret_key
      @session_key        = session_key
      secure_with_session_key!(session_key) unless !session_key
    end
    
    def call(method, params ={})
      @scope = nil
      Api.new(self).call(method, params)
    end
    
    def secure_with_session_key!(session_key)
      @session_key = session_key
      @user_facebook_uid = self.call('users.getLoggedInUser', :session_key => session_key).data
    end
    
    def secured?
      !!@user_facebook_uid
    end
    
    # Allow session to dynamically call API method
    def method_missing(method_name, args={})
      if !!@scope
        self.call("#{@scope}.#{method_name}", args)
      else
        @scope = method_name
        self
      end
    end
  end
end