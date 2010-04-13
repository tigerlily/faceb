module FaceB
  require 'cgi'
  class Session
    attr_reader :api_key, :secret_key, :session_key, :facebook_user_uid
    
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
      @facebook_user_uid = self.call('users.getLoggedInUser', :session_key => session_key).data
    end
    
    def secured?
      !!@user_facebook_uid
    end
    
        
    ##
    # Return the login url for current Facebook application
    # 
    # @param [Hash] params Options to pass to the URL
    # @return [String] Current Facebook application login url
    # 
    # @example Login url with next URL and display params
    #   session.login_url(:next => 'http://www.example.com', :display => 'popup')
    #   => http://www.facebook.com/login.php?api_key=xxxxxxxxxx&v=1.0&next=http%3A%2F%2Fwww.example.com&display=popup
    def login_url(params={})
      url = "http://www.facebook.com/login.php"
      params = {:api_key => api_key, :v => '1.0'}.merge(params)
      params_str = params.map {|param, value| "#{param}=#{::CGI.escape(value)}"}.join('&')
      [url, params_str].join '?'
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