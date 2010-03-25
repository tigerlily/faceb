module FaceB
  class << self
    ##
    # Return the current Facebook session
    # 
    # @return [FaceB::Session] The current facebook session
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
    # @return [FaceB::Session] The new current facebook session
    # 
    # @example Create a new session
    #   FaceB.new('api-key', 'secret-key')
    # @example Create a new session with a specific session key
    #   FaceB.new('api-key', 'secret-key', 'session-key')
    # 
    # @see FaceB::Session.create
    def new(api_key = nil, secret_key = nil, session_key = nil)
      Session.create(api_key, secret_key, session_key)
    end
    
    ##
    # Call a Facebook API method
    # 
    # @param [String] api_key The Facebook application api key
    # @param [String] secret_key The Facebook application secret key
    # @param [String] method The API method to call
    # @param [Hash] params Params to pass to API method call (see FaceB::Api#call)
    # 
    # @return [FaceB::Api::Response] The API method response
    # 
    # @example Call a method
    #   FaceB.call('api-key', 'secret-key', 'method.name', :key1 => 'value1')
    # @example Call a method with a specific
    #   FaceB.call('api-key', 'secret-key', 'method.name', :key1 => 'value1', :secret_key => 'session-key')
    # 
    # @see FaceB::Api#call
    # @see FaceB::Session#call
    def call(api_key, secret_key, method, params = {})
      Session.new(api_key, secret_key).call(method, params)
    end
  end
end