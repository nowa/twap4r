class Tapi::WelcomeController < ApplicationController
  
  def index
    logger.info { "request: #{request.path}" }
    logger.info { "ori: #{params[:ori]}" }
    authenticate_with_http_basic do |username, password|
      logger.info { "http basic username: #{username}\nhttp basic password: #{password}" }
    end
  end
  
end
