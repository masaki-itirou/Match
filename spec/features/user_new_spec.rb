require 'rails_helper'

RSpec.describe "user_new",type:feature,js:true do
  
  before do
    allow(I18n).to receive(:locale).and_return(:en)
    allow_any_instance_of(ApplicationController).to receive(:switch_layout) {"not_login_land"}      
  end
  #DBが空なら上手く行く。
  xfeature "success move" do
    before do
      visit "/user/new"
      up = attributes_for(:user)
      fill_in("user_new_name",with:up[:name])
      fill_in("user_new_password",with:"test")  
      fill_in("user_new_confirm_password",with:"test")
      select("English",from:"user_new_lang")
    end
    
    it "render" do      
      expect(current_path).to eq("/user/new")        
    end
    
    it "move to login form" do
        find("#user_new_send").click      
        #page.save_screenshot('test/pic/move_to_login_form.png')
        #wait_for_ajax
        expect(current_path).to eq("/login/form")
    end
  end
  
  feature "success User" do
    before do
      visit "/user/new"
      up = attributes_for(:user)
      fill_in("user_new_name",with:up[:name])
      fill_in("user_new_password",with:"test")  
      fill_in("user_new_confirm_password",with:"test")
      select("English",from:"user_new_lang")
    end
    
    xit "added user" do 
      expect do 
        find("#user_new_send").click        
        wait_for_ajax        
      end.to change{User.count}.by(1)

    end
    
  end  
      
end