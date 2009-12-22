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
      twitter = TwitterOAuth::Client.new(
            :consumer_key => 'rubLpKupoXt4JlQCiCm7Q',
            :consumer_secret => 'KJu6pKzr1Wj1yqUffrVaPak3oLTsAlZO5IX8hmrJDM'
      )
      oauth_confirm_url = request.host + "/oauth_callback"
      logger.info { "oauth_confirm_url" }
      request_token = twitter.request_token(:oauth_callback => oauth_confirm_url)
      access_token = request_token.authorize(
        request_token.token,
        request_token.secret,
        :oauth_verifier => params[:oauth_verifier]
      )
    end
end
