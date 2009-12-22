class WelcomeController < ApplicationController
  
  before_filter :oauth, :except => [:oauth_callback]
  
  def index
    logger.info { "#{@client.friends_timeline.inspect}" }
  end
  
  def oauth_callback
    access_token = @client.authorize(
          session[:request_token],
          session[:request_token_secret],
          :oauth_verifier => params[:oauth_verifier]
    )
    
    if @client.authorized?
    
      File.open(@config_file, 'w') do |out|
        @config['oauth']['request_token'] = access_token.token
        @config['oauth']['request_secret'] = access_token.secret
        YAML::dump(@config, out)
      end
    
      redirect_to root_path and return
    else
      
    end
  end
  
end
