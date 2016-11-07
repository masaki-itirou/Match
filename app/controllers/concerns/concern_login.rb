module ConcernLogin 
  extend ActiveSupport::Concern
  include ConcernGeneral
  
  def login_is_possible?(name,password,seed)        
    user_info = User.where(name:name).limit(1).select('id,password')      
    if user_info.blank?
      return false
    end
    if password_check(user_info.pluck(:password).first,password,seed)
      return user_info.pluck(:id).first
    else      
      return false
    end
  end
end