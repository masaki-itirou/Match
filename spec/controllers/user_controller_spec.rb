require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "GET #new" do
    before {get :new}
    it "render user/new.html.erb" do    
      expect(response).to render_template :new
    end
  end
  
  describe "POST #create" do
    
    context "success" do
      before do        
        xhr :post,:create,{name:"test_name",password:"test_password",lang:"ja"}
      end
    
      it "render" do
        expect(response).to render_template "share/location_href"
      end
    
      it "@href" do      
        #expect(controller.instance_variable_get("@href")).to eq("/login/form")        
        expect(assigns(:href)).to eq("/login/form")
      end
      
      it "user-thumbnail" do
        u = User.where(name:"test_name").first.thumbnail.present?
        expect(u).to eq(true)
      end
      
    end
    
    it "check user record have added" do
      expect do
        xhr :post,:create,{name:"test_name",password:"test_password",lang:"ja"}
      end.to change{User.count}.by(1)
    end           
  end
  
  describe "POST #update" do
    
    let(:own) {create(:user,name:"n1",password:"test_password",contact:"c1")}
    
    before do                    
      allow(controller).to receive(:user_authentication).and_return(true)
      allow(controller).to receive(:get_own).and_return(own)      
    end
    
    context "success" do
      before do
        allow(controller).to receive(:used_name?).and_return(false)  
      end
      
      let(:hash) {{name:"n2",lang:"ja",contact:"c2"}}
                
      it "change name" do
        expect do                        
          xhr :post,:update,hash
        end.to change{own.contact}.from("c1").to("c2")
      end
      
      it "change name 2" do
        xhr :post,:update,hash
        expect(own.name).to eq("n2")   
      end
    
      it "render" do
        xhr :post,:update,hash
        expect(response).to render_template "message/fadeout"
      end      
    end#context=success
    
    context "fail" do
      let(:hash) {{name:"n3",lang:"ja",contact:"c2"}}      
      it "used_name" do        
        create(:user,name:"n3",password:"test_password",contact:"c1")
        xhr :post,:update,hash
        expect(controller.instance_variable_get("@type")).to eq(false)
      end
    end
    
  end
  
end
