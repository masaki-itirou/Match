module ConcernGeneral 
  extend ActiveSupport::Concern

  
  def get_error_log_file_name
    Time.now.year.to_s+"-"+Time.now.month.to_s+"-"+Time.now.day.to_s
  end
  
  def get_spare_error_log_file_name
    "spare-"+Time.now.year.to_s+"-"+Time.now.month.to_s+"-"+Time.now.day.to_s    
  end
  
  def write_error_log(msg)    
    begin
      File.open("log/error/"+get_error_log_file_name,"a") do |f|
        f.puts(msg)
      end
    rescue => e
      text = e.message + " In write_error_log"
      logger.error(text)
       File.open("log/error/"+get_spare_error_log_file_name,"a") do |f|
        f.puts(text)
        f.puts("tried msg:" + msg)
      end
    end
  end
    
  def store_image(image,path,name)
    begin
      img = Magick::Image.from_blob(image.read).shift
      img.format = "JPEG"
      img.resize!(Image::WIDTH,Image::HEIGHT)
      img.write(path+name)   
      #メモリを開放
      img.destroy!
      return true
    rescue => e
      write_error_log(e.message)
      return false
    end    
  end
  
  def password_check(stored_pw,send_pw,seed)    
    if Digest::SHA512.hexdigest(seed + stored_pw) == send_pw
      return true
    else      
      return false
    end
  end
  
  def get_own
    begin
      User.find(session[:user_id])
    rescue => e
      return false
    end
  end
  
  def save_transaction(&block)
    result,failed = false,0    
    begin      
      ActiveRecord::Base.transaction do        
        result = block.call
      end      
    rescue ActiveRecord::StaleObjectError => e
      write_error_log("競合エラー:" + e.message)            
    rescue => e
      #Rails.logger.error(e.message)
      write_error_log(e.message)
    ensure
      return result    
    end    
  end
  
  #save,save!の両方に対応
  def save_block(&block)
    begin 
      raise("Exception") if block.call == false
    rescue => e
      write_error_log("save_block:"+e.message)
      return false
    end
    return true
  end
  
end