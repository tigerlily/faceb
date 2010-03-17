module Facebook
  class Session
    attr_reader :api_key, :secret_key, :session_key
    
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
    
    def initialize(api_key, secret_key, session_key = nil)
      @api_key      = api_key
      @secret_key   = secret_key
      @session_key  = session_key
    end
    
    def call(method, params ={})
      Api.new(self).call(method, params)
    end
  end
end