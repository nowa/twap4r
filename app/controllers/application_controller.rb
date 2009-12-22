# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include TwitterOAuth
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :oauth
  
  protected
  
    def oauth
      @authorized = false
      @config_file = "#{RAILS_ROOT}/config/oauth.yml"
      @config = YAML::load(File.read(@config_file))
      consumer_key = @config['oauth']['consumer_key']
      consumer_secret = @config['oauth']['consumer_secret']
      request_token = @config['oauth']['request_token']
      request_secret = @config['oauth']['request_secret']
      
      if request_token.nil? and request_secret.nil?
        @client = TwitterOAuth::Client.new(
               :consumer_key => consumer_key,
               :consumer_secret => consumer_secret
               )
        
        return if request.path.gsub("/", "") == "oauth_callback"
        
        request_token = @client.request_token
        session[:request_token] = request_token.token
        session[:request_token_secret] = request_token.secret
        @authorize_url = request_token.authorize_url
      else
        @authorized = true
        @client = TwitterOAuth::Client.new(
            :consumer_key => consumer_key,
            :consumer_secret => consumer_secret,
            :token => request_token,
            :secret => request_secret
          )
      end
    end
end
