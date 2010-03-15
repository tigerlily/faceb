module Facebook
  class Session
    attr_reader :api_key, :secret_key
    
    def self.create(api_key, secret_key)
      @current_session = self.new(api_key, secret_key) unless defined?(@current_session)
      @current_session
    end
    
    def self.current
      @current_session
    end
    
    def initialize(api_key, secret_key)
      @api_key    = api_key
      @secret_key = secret_key
    end
    
    def call(method, params ={})
      Api.new(self).call(method, params)
    end
  end
end