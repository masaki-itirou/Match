class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,unique:true,null:false
      t.string :password,null:false
      t.string :word,default:""
      t.string :contact,default:""
      t.string :thumbnail,default:"not"
      t.string :search_result,default:empty_hash_yaml,null:false
      t.string :result_valid_time,default:default_valid_time
      t.string :lang,default:"en",null:false
      t.integer :lock_version,default:0
      t.timestamps null: false
    end
  end
  
  def default_valid_time
      return (Time.now.utc - MatchLimit::VALID_TIME).to_s
  end
    
  def empty_hash_yaml
    {}.to_yaml
  end
end
