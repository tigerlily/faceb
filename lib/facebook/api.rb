require 'httparty'
require 'digest/md5'

module Facebook
  # Api
  class Api
    include HTTParty
    default_params :format => 'JSON', :v => '1.0'
    API_SERVER_URL = "http://api.facebook.com/restserver.php"
    
    def initialize(session)
      @session  = session
    end
    
    def call(method, params = {})
      p = Api.default_params.merge(:method => method, :call_id  => Time.now.tv_sec.to_s, :api_key => @session.api_key)
      p.merge!(params)
      
      Response.new(Api.post(API_SERVER_URL, :body => generate_signature(p, @session.secret_key)))
    end
    
    private
      def generate_signature(params, secret)
        p = params.map { |name, value| "#{name}=#{value}" }.sort.join
        params.merge(:sig => Digest::MD5.hexdigest([p, secret].join))
      end
      
    # Response
    class Response
      attr_reader :data
      
      def initialize(data)
        @data = data
      end
      
      def error
        {:code =>  @data['error_code'], :msg => @data['error_msg'] }
      end
    end
  end
end