class Tapi::WelcomeController < ApplicationController
  
  def index
    logger.info { "request: #{request.path}" }
    logger.info { "ori: #{params[:ori]}" }
    result = ""
    authenticate_with_http_basic do |username, password|
      logger.info { "http basic username: #{username}\nhttp basic password: #{password}" }
      if request.post?
        logger.info { "p: #{hash_to_querystring(params)}" }
        result = `curl -d "#{hash_to_querystring(params)}" http://twitter.com#{params[:ori]}`
        logger.info { "curl: curl -d "#{hash_to_querystring(params)}" http://twitter.com#{params[:ori]}" }
      else
        result = `curl http://twitter.com#{params[:ori]}`
        logger.info { "curl: curl http://twitter.com#{params[:ori]}" }
      end
    end
    logger.info { "result: #{result}" }
    render :text => result
  end
  
  private
  
    def hash_to_querystring(hash)
      hash.delete(:action)
      hash.delete(:controller)
      hash.keys.inject('') do |query_string, key|
        query_string << '&' unless key == hash.keys.first
        query_string << "#{URI.encode(key.to_s)}=#{URI.encode(hash[key])}"
      end
    end
  
end
