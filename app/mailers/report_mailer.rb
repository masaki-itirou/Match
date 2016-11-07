class ReportMailer < ApplicationMailer
  default from:MyMail::AD
  
  include ConcernGeneral
  
  def report    
    @date = get_error_log_file_name
    @spare_date = get_spare_error_log_file_name
    
    begin
      File.open("log/error/"+@date,"r") do |f|      
        @error_content = f.read        
      end      
    rescue Errno::ENOENT => e
      @error_content = "Nothing"
    rescue => e
      @error_content = e.message
    end
    
    begin
      File.open("log/error/"+@spare_date,"r") do |f|      
        @spare_error_content = f.read        
      end      
    rescue Errno::ENOENT => e
      @spare_error_content = "Nothing"
    rescue => e
      @spare_error_content = e.message      
    end
    
    mail(to: MyMail::AD,subject:"report:"+@date)
  end
  
end
