module ConcernUser 
  extend ActiveSupport::Concern
  include ConcernGeneral
  
  def make_thumbnail_name(id)
    Digest::SHA512.hexdigest(id.to_s + Image::MOZAIKU) + Image::TYPE
  end
  
  def used_name?(name)
    User.where('name=?',params[:name]).exists?
  end
  
  def change_word(old_word_ary,new_word_ary,own_id)
    #追加されるwordはnewにはあって、oldにはないword
    add_word = new_word_ary.reject do |word|  
      old_word_ary.include?(word)
    end
    #削除されたwordのみの配列を作成
    #削除されるwordはoldにはあって、newにはないword
    del_word = old_word_ary.reject do |word| 
      new_word_ary.include?(word)
    end
    add_point = Point.where(word:add_word)
    add_point.each do |point|
      #ループ終了後にadd_wordに残ったwordが未使用の新しくレコードを作成する必要があるword
      add_word.delete(point.word)
      point.user_id << " " << own_id  
    end

    create_point = []
    add_word.each do |word|
      point = Point.new
      create_point.push(point)
      point.word = word
      point.user_id = own_id  
    end

    del_point = Point.where(word:del_word)

    del_point.each do |point|
      user_id = point.user_id.split(/\s+/)
      user_id.delete(own_id)
      point.user_id = user_id.join(" ")
    end
    
    add_point.concat(create_point)
    
    own = get_own
    own.word = new_word_ary.join(" ")
    #A idea 
    #まとめて更新する。    
    res = save_transaction do
      break false unless own.save      
      (add_point+del_point).each do |point|
        break false unless point.save        
      end
    end
    write_error_log("change word failed.#{Time.now}") unless res
    return res              
  end
end