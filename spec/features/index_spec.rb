require 'rails_helper'

RSpec.describe "index",type:feature,js:true do
  
  feature "visit index" do  
    before do      
      allow(I18n).to receive(:locale).and_return(:en)
      allow_any_instance_of(ApplicationController).to receive(:switch_layout) {"not_login_land"}      
      visit "/"    
    end  
    it "render" do      
      expect(current_path).to eq("/")      
    end
    
    it "content" do
      expect(page).to have_content("This site allow users")
    end

    it "move to create account" do
      page.first("#other_index_button_create_account").click              
      expect(current_path).to eq("/user/new")
    end
    
    it "move to login" do
      page.first("#other_index_button_login").click
      expect(current_path).to eq("/login/form")
    end
  end
  
end
