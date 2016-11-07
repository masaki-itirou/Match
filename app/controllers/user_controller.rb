class UserController < ApplicationController
  protect_from_forgery except:[:update_thumbnail]
  before_action :user_authentication,except:[:new,:create,:delete_success]
  
  include ConcernUser
  
  def new            
    instance_variable_set("@"+I18n.locale.to_s,"selected=true")
  end
  
  def create
    own = User.new      
    if used_name?(params[:name])
      #ir18nを使う。
      @type,@text = false,t("user.used_name")
      render "message/fadeout" and return
    else
      own.name = params[:name]
    end          
    own.password = params[:password]    
    own.lang = params[:lang]
    #idを取得するために一度セーブ
    save_block {own.save!}
    own.thumbnail = make_thumbnail_name(own.id)
    if save_block {own.save!}
      thum = Image::THUMBNAIL_PATH+own.thumbnail
      begin
        if File.exist?(thum)
          File.delete(thum)
        end
        File.symlink(
          File.expand_path(Image::THUMBNAIL_PATH + Image::DEFAULT_NAME),      
          thum)
      rescue => e
        write_error_log("user#create:#{e.message}")
        @type,@text = false,"create failed"
        render "message/fadeout" and return
      end    
      @href = "/login/form"      
      render "share/location_href"
      
    else 
      @type,@text = false,"create failed"
      render "message/fadeout" 
    end  
  end
  
  def show_update
    @own = get_own || (render nothing:true and return)
    instance_variable_set("@"+I18n.locale.to_s,"selected=true")    
  end
  
  def update
    own = get_own || (render nothing:true and return)    
    if params[:name] != own.name      
      if used_name?(params[:name])        
        @type,@text = false,t("user.used_name")
        render "message/fadeout" and return
      else
        own.name = params[:name]
      end  
    end
    own.password = params[:password] if params[:password].present?
    own.lang = params[:lang]        
    own.contact = params[:contact].split(/\s+/).join(" ")        
    if save_block {own.save!} 
      @type,@text = true,"update success"      
    else
      @type,@text = false,"update failed"
    end
    render "message/fadeout"
  end
  
  def update_word
    own = get_own || (render nothing:true and return)
    old_word = own.word.split(/\s+/)
    new_word = params[:word].split(/\s+/)
    unless new_word == old_word
      #word change      
      if change_word(old_word,new_word,own.id.to_s)
        @type,@text = true,"update success"      
      else 
        @type,@text = false,"update failed"      
      end
      render "message/fadeout" and return
    end
    render nothing:true
  end
    
  def update_thumbnail    
    own = get_own || (render nothing:true and return)       
    begin
      File.delete(Image::THUMBNAIL_PATH+own.thumbnail)
    rescue
      #これ以前に画像ファイルの保存に失敗した場合、削除するファイルが存在しなくなるため例外が起きるので。
    end
    if store_image(params[:image],Image::THUMBNAIL_PATH,own.thumbnail)      
      @type,@text = true,"image update success"
    else
      @type,@text = false,"image update failed"                  
    end
    render "message/fadeout"
  end
  
  def send_word
    own = get_own || (render nothing:true and return)
    render text:own.word
  end
  
  def delete    
    own = get_own || (render nothing:true and return)
    begin
      own.destroy!      
      reset_session
    rescue => e
      write_error_log("user#delete:#{e.message}")
      @type,@text = false,"delete failed"
      render "message/fadeout" and return
    end
    @href = "/user/delete_success"
    render "share/location_href"
  end
  
  def delete_success
  end

end
