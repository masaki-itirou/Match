class AddIndexToPoint < ActiveRecord::Migration
  def change
    add_index :points,:word,unique:true
  end
end
