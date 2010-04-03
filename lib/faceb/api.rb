require 'httparty'
require 'digest/md5'

module FaceB
  # Api
  class Api
    include HTTParty
    default_params :format => 'JSON', :v => '1.0'
    API_SERVER_URL = "http://api.facebook.com/restserver.php"
    
    def initialize(session)
      @session  = session
    end
    
    ##
    # Call a Facebook API method
    # 
    # @param [String] method The API method to call
    # @param [Hash] params Params to pass to API method call
    # @option params [Boolean, String] :session_key if true use the current Facebook session key else if string use this string as session key
    # 
    # @return [FaceB::Api::Response] The API method response
    def call(method, params = {})
      params[:call_id] = Time.now.tv_sec.to_s if params.delete(:call_id)
      params[:session_key] = @session.session_key if params[:session_key] == true && !!@session.session_key
      
      puts "METHOD : #{method}, PARAMS : #{params.inspect}"
      p = Api.default_params.merge(:method => method, :api_key => @session.api_key)
      p.merge!(params)
      
      Response.new(Api.post(API_SERVER_URL, :body => generate_signature(p, @session.secret_key)))
    end
    
    private
      def generate_signature(params, secret)
        p = params.map { |name, value| [name, value].join('=') }.sort.join
        params.merge(:sig => Digest::MD5.hexdigest([p, secret].join))
      end
      
    # Response
    class Response
      attr_reader :data
      
      def initialize(data)
        @data = data
        raise Error.new(data["error_code"], data["error_msg"]) if data.respond_to?(:include?) && data.include?("error_msg")
      end
      
      def method_missing(name, *args)
        if @data.is_a?(Hash)
          @data[name.to_s]
        elsif @data.is_a?(Array) && @data.size == 1 && @data.first.is_a?(Hash)
          @data.first[name.to_s]
        end
      end
      
      def error
        {:code =>  @data['error_code'], :msg => @data['error_msg'] }
      end
    end
    
    # Api Error
    class Error < StandardError
      def initialize(error_code, error_msg)
        super("Facebook error #{error_code} : '#{error_msg}'")
      end
    end
    
  end
end