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
    # 
    # @example Create a new session
    #   Facebook.new('api-key', 'secret-key')
    # @example Create a new session with a specific session key
    #   Facebook.new('api-key', 'secret-key', 'session-key')
    # 
    # @see Facebook::Session.create
    def new(api_key = nil, secret_key = nil, session_key = nil)
      Session.create(api_key, secret_key, session_key)
    end
    
    ##
    # Call a Facebook API method
    # 
    # @param [String] api_key The Facebook application api key
    # @param [String] secret_key The Facebook application secret key
    # @param [String] method The API method to call
    # @param [Hash] params Params to pass to API method call (see Facebook::Api#call)
    # 
    # @return [Facebook::Api::Response] The API method response
    # 
    # @example Call a method
    #   Facebook.call('api-key', 'secret-key', 'method.name', :key1 => 'value1')
    # @example Call a method with a specific
    #   Facebook.call('api-key', 'secret-key', 'method.name', :key1 => 'value1', :secret_key => 'session-key')
    # 
    # @see Facebook::Api#call
    # @see Facebook::Session#call
    def call(api_key, secret_key, method, params = {})
      Session.new(api_key, secret_key).call(method, params)
    end
  end
end