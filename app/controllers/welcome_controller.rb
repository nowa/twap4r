class WelcomeController < ApplicationController
  
  def index
    logger.info { "#{@client.friends_timeline}" }
  end
  
  def oauth_callback
    access_token = @client.authorize(
          session[:request_token],
          session[:request_token_secret]
    )
    
    File.open(@config_file, 'w') do |out|
      @config['oauth']['request_token'] = access_token.token
      @config['oauth']['request_secret'] = access_token.secret
      YAML::dump(@config, out)
    end
    
    redirect_to root_path
  end
  
end
