require 'rails_helper'

RSpec.describe MatchController, type: :controller do
  describe "GET #Show" do
    
    let(:own) {create(:user,name:"n1",password:"test_password",contact:"c1")}
        
    before do
      allow(controller).to receive(:user_authentication).and_return(true)
      allow(controller).to receive(:get_own).and_return(own)
    end
    
    context "synchronous access" do      
      it "render" do
        get :show
        expect(response).to render_template "match/show"
      end
    end
    
    context "asynchronous access" do      
      it "render" do
        xhr :get,:show
        expect(response).to render_template "match/show"
      end
    end
  end
end

   