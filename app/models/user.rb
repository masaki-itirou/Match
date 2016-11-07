class User < ActiveRecord::Base

  validates :name,presence:true,uniqueness:true
      
  validate :check_length,on:[:update,:create]
  
  private 
  
  def check_length    
    if name.length > UserLimit::NAME
      errors.add(:name,"name is too long")
    end 
    
    if word.length > UserLimit::WORD
      errors.add(:word,"word is too long")
    end
    
    if contact.length > UserLimit::CONTACT
      errors.add(:contact,"contact is too long")
    end
  end  
end
