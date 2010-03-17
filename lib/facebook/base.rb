module Facebook
  class << self
    def current_session
      Session.current
    end
    
    def new(api_key = nil, secret_key = nil)
      Session.create(api_key, secret_key)
    end
    
    def call(api_key, secret_key, method, params = {})
      Session.new(api_key, secret_key).call(method, params)
    end
  end
end