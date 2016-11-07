class XtestJob < ActiveJob::Base
  
  include ConcernGeneral
  
  queue_as :default
  
  def perform(*args)
    write_error_log("XtestJob was did.")
  end
end
