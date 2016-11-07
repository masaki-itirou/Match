class InitUsingLogJob < ActiveJob::Base
  queue_as :default

  def perform()
    UsingLog.login_num = 0
    UsingLog.match_num = 0
    InitUsingLogJob.set(wait_until: Time.now.tomorrow.midnight).perform_later     
  end
end
