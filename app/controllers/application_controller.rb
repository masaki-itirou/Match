class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :user_authentication,:switch_lang
  layout :switch_layout
  
  include ConcernGeneral    
  
  #rescur_fromは下から走査されるため、Exceptionのような上位？の例外ほど上に書く。
  rescue_from Exception, with: :render_500 
  rescue_from ActiveRecord::RecordNotFound, with: :no_data
  rescue_from ActionController::RoutingError, with: :no_page
  
  def no_data(e = nil)    
    @text = "Sorry,this record has been removed."            
    unless request.xhr?      
      render "message/text",status:500
    else
      @type = false
      render "message/fadeout",status:500
    end
  end
  
  def no_page(e = nil)
    @message = "Your request page does'nt exist."
    render "error_page/message",status:404
  end
  
  def render_500(e = nil)    
    write_error_log(e.message) if e
    @text = "Sorry,this system have got trouble."        
    unless request.xhr?      
      render "message/text",status:500
    else
      @type = false
      render "message/fadeout",status:500
    end    
  end
    
  def switch_lang
    user = get_own  
    if user            
      if user.lang.present?
        I18n.locale = user.lang
        return                      
      end
    else
      case (request.headers['Accept-Language'] || "ja").split(",").first 
      when "ja"
        I18n.locale = "ja"
      else 
        I18n.locale = "en"
      end
    end
  end
  
  def user_authentication
    unless session[:user_id]
      redirect_to "/other/index"
    end
  end
  
  def switch_layout    
    agent = request.headers['User-Agent']
    if agent.scan("Mobile").present?      
      if session[:user_id].present?
        return "mobile"
      else
        return "not_login_mobile"
      end
    else    
      if session[:user_id].present?
        return "land"
      else
        return "not_login_land"
      end
    end
  end
end
