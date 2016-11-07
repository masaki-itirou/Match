class OtherController < ApplicationController
  
  before_action :user_authentication,only:[:tutorial]
    
  def tutorial
    render "tutorial_" + I18n.locale.to_s    
  end
  
  def index
    render "index_" + I18n.locale.to_s
  end  
end
