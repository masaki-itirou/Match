require 'rails_helper'

RSpec.describe "login",type:feature,js:true do
  let(:own){ create(:user)}          
  before do
    allow(I18n).to receive(:locale).and_return(:en)
    allow_any_instance_of(ApplicationController).to receive(:switch_layout) {"not_login_land"}
    #login_is_possible?が通らない。
    allow_any_instance_of(ConcernLogin).to receive(:login_is_possible?) {own.id}
    allow_any_instance_of(ConcernGeneral).to receive(:get_own) {own}    
  end
  
  feature "login success" do
    
    before do
      visit "/login/form"
      ns = "login_form_"
      fill_in(ns+"name",with:own.name)
      fill_in(ns+"password",with:"r")  
    end
    
    it "render" do      
      expect(current_path).to eq("/login/form")        
    end
    
    #
    it "move to tutorial" do
        #page.save_screenshot('test/pic/login_before.png')
        find("#login_form_send_button").click              
        wait_for_ajax
        expect(current_path).to eq("/other/tutorial")
    end
    
  end
end