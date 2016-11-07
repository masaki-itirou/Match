ReportMailJob.set(wait_until: Time.now.tomorrow.midnight.ago(60)).perform_later
InitUsingLogJob.set(wait_until: Time.now.tomorrow.midnight).perform_later

#rake db:migrate:resetを実行するとdelayed_jobsが見つからない的なエラーが出るのでコメントアウトしておく。
