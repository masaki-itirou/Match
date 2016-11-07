class LoginController < ApplicationController
  before_action :user_authentication,except: [:form,:check]
  include ConcernLogin
  def logout
    reset_session    
    redirect_to "/other/index"
  end
  
  def form
    @seed = Random.new_seed.to_s    
  end
  
  #ログイン処理、ＤＢ内のデータとの照合 
  def check
    #ログインに失敗すればfalseが返される
    user_id = login_is_possible?(params[:name],params[:password],params[:seed])      
    if user_id
      #ログイン成功
      reset_session
      UsingLog.login_num += 1
      session[:user_id] = user_id.to_s      
    else         
      @type,@text = false,"login failed"
      render "message/fadeout" and return
    end
    @href =  get_own.lock_version <= 1 ? "/other/tutorial":"/match/show"
    render "share/location_href"
  end
end
