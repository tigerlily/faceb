module Facebook
  class << self
    ##
    # Return the current Facebook session
    # 
    # @return [Facebook::Session] The current facebook session
    def current_session
      Session.current
    end
    
    ##
    # Create a new Facebook session
    # 
    # @param [String] api_key The Facebook application api key
    # @param [String] secret_key The Facebook application secret key
    # @param [String] session_key The session key of a Facebook user
    # 
    # @return [Facebook::Session] The new current facebook session
    def new(api_key = nil, secret_key = nil, session_key = nil)
      Session.create(api_key, secret_key, session_key)
    end
    
    ##
    # Call a Facebook API method
    # 
    # @param [String] api_key The Facebook application api key
    # @param [String] secret_key The Facebook application secret key
    # @param [String] method The API method to call
    # @param [Hash] params Params to pass to API method call
    # 
    # @return [Facebook::Api::Response] The API method response
    def call(api_key, secret_key, method, params = {})
      Session.new(api_key, secret_key).call(method, params)
    end
  end
end