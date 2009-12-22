class Api::WelcomeController < ApplicationController
  
  def index
    logger.info { "request: #{request.path}" }
    authenticate_with_http_basic do |username, password|
      logger.info { "http basic username: #{username}\nhttp basic password: #{password}" }
    end
  end
  
end
