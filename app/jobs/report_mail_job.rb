class ReportMailJob < ActiveJob::Base
  
  include ConcernGeneral

  queue_as :default
  
  rescue_from(Exception) do |e|
    write_error_log("To send mail failed.#{e.message}")        
  end
  
  def perform  
     ReportMailer.report.deliver_now
     ReportMailJob.set(wait_until: Time.now.since(2.days).midnight.ago(60)).perform_later
  end
end
