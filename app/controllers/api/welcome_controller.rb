class Api::WelcomeController < ApplicationController
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => {:a => "a"} }
    end
  end
  
end
