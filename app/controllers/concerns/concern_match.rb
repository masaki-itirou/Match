module ConcernMatch
  extend ActiveSupport::Concern
  include ConcernGeneral

  def get_match_user(user,page)
    word_ary = user.word.split(/\s+/)        
    sr_hash = get_match(word_ary)
    user.search_result = sr_hash.to_yaml
    user.result_valid_time = (Time.now.utc + MatchLimit::VALID_TIME).to_s
    #検索結果を保存、キャッシュとして使う。    
    save_block{user.save!}
    #user_obj,{user_id:[match_word...]}
    #sr_hash.keysは順番通りの値の配列を返す。
    return get_sorted_user(sr_hash.keys,page),sr_hash
=begin    
    #order_as_specifiedを使う場合
    #これでuser_id_aryで指定した順番にuserレコードが入っているとのこと
    return User.where(id:user_id_ary).order_as_specified(id:user_id_ary)
=end
  end
  
  def get_sorted_user(sorted_user_id_ary,page)
    #User.whereは順番を保障しない。
    #user_hashをソートせず、sr_hashを利用してソートした順にデータを取り出す場合
    #この場合、sort_user_aryを廃止してuser_id_aryとuser_hashを返してテンプレートで値を取り出す方がわずかに効率的
    #{id:<user_data>,...}のハッシュ形式でデータを取得出来る。    
    sort_user_ary = []
    user_hash = User.where(id:sorted_user_id_ary).
      limit(MatchLimit::SHOW_NUMBER).offset(page*MatchLimit::SHOW_NUMBER).index_by(&:id)    
    sorted_user_id_ary.each do |user_id|
      user = user_hash[user_id.to_i]            
      if user
        sort_user_ary.push(user)
      end
      user_hash.delete(user_id)
      next
    end        
    return sort_user_ary
  end
  
  def get_match(word_ary)    
    point_ary = Point.where(word:word_ary)
    sr_hash = {}    
    point_ary.each do |point|
      user_id_ary = point.user_id.split(/\s+/)      
      user_id_ary.each do |u_id|
        sr_ary = sr_hash[u_id] || []
        sr_ary.push(point.word)
        sr_hash[u_id] = sr_ary
      end      
    end
    #自身のidを取り除く
    sr_hash.delete(get_own.id.to_s)    
    #sr_hash[id].lengthで降順にソート（大=>小)
    #sr_hash:{user_id:[match_word,...],...}
    sr_hash.sort_by { |_,v| -(v.length) }
    return sr_hash
  end
  
end