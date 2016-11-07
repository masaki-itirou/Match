require 'rails_helper'

describe ConcernGeneral do

  let(:test_class) { Struct.new(:mock) { include ConcernGeneral } }
  let(:gl) { test_class.new }

  describe "#get_error_log_file_name" do
    context "test" do
      it "file name is date" do
        expect(gl.get_error_log_file_name).to eq(Time.now.year.to_s+"-"+Time.now.month.to_s+"-"+Time.now.day.to_s)    
      end
    end
  end
  
  describe "#save_block" do
    let(:user){build(:user)}
    it "true" do
      expect(gl.save_block do
        user.save
      end).to eq(true)
    end
    
    it "false" do
      expect(gl.save_block do
       user.name = "a" * UserLimit::NAME + "b"
       user.save 
      end).to eq(false)
    end
    
    it "false exception" do
      expect(gl.save_block do
        raise "Exception"
      end).to eq(false)
    end
    
    
  end
end
