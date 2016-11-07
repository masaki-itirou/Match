Rails.application.routes.draw do
  
  root to: "other#index"
  #xtest
  get "/xtest/success"
  get "/xtest/show_user"
  get "/xtest/show_point"
  get "/xtest/temp"
  get "/xtest/mail"
  get "/xtest/check_job"
  get "/xtest/job_mail"
  
  #login
  get  '/login/logout'
  get  '/login/form'
  post  '/login/check'
  #match
  get '/match/show'    
  #other
  get '/other/tutorial'
  get '/other/index'
  #user
  get '/user/new'
  post '/user/create'
  get '/user/show_update'
  post '/user/update'
  post '/user/update_word'
  post '/user/update_thumbnail'
  post '/user/send_word'
  post '/user/delete'
  get '/user/delete_success' 
end
