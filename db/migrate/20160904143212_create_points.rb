class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :word,null:false
      t.text :user_id,null:false,default:""
      t.integer :lock_version,default:0
      t.timestamps null: false
    end
  end
end
