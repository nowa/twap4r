class Tapi::WelcomeController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  def dispatch
    logger.info { "request: #{request.path}" }
    ori = params[:ori].join('/')
    
    result = ""
    basic_auth = ""
    authenticate_with_http_basic do |username, password|
      logger.info { "http basic username: #{username}\nhttp basic password: #{password}" }
      
      basic_auth = "#{username}:#{password}@"
    end
    
    logger.info { "p: #{hash_to_querystring(params)}" }
    
    if request.post?
      result = `curl -d "#{hash_to_querystring(params)}" http://#{basic_auth}twitter.com/#{ori}`
      logger.info { "curl: curl -d \"#{hash_to_querystring(params)}\" http://#{basic_auth}twitter.com/#{ori}" }
    else
      result = `curl http://#{basic_auth}twitter.com/#{ori}?#{hash_to_querystring(params)}`
      logger.info { "curl: curl http://#{basic_auth}twitter.com/#{ori}?#{hash_to_querystring(params)}" }
    end
    
    # logger.info { "result: #{result}" }
    render :text => result
  end
  
  private
  
    def hash_to_querystring(hash)
      hash.delete(:action)
      hash.delete(:controller)
      hash.delete(:ori)
      hash.keys.inject('') do |query_string, key|
        query_string << '&' unless key == hash.keys.first
        query_string << "#{URI.encode(key.to_s)}=#{URI.encode(hash[key])}"
      end
    end
  
end
