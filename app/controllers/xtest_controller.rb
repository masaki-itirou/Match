class XtestController < ApplicationController
  skip_before_action :user_authentication
  
  include ConcernGeneral
    
  def success    
  end
  
  def temp
    render text:UsingLog.match_num
  end
  
  def check_job    
    XtestJob.set(wait: 5.second).perform_later
    render text:"Check Job"
  end
  
  def mail    
    write_error_log("OK:#{Time.now}")
    ReportMailer.report.deliver_now
    render text:"mail"
  end
  
  def job_mail
    write_error_log("OK:#{Time.now}")
    ReportMailJob.set(wait: 10.second).perform_later    
    render text:"job_mail"
  end
  
  def show_user
    @current = nil
    @current = session[:user_id]
    @models = User.all
    render "xtest/show_model_data"
  end
  
  def show_point
    @current = nil
    @current = session[:user_id]
    @models = Point.all
    render "xtest/show_model_data"
  end
  
end
