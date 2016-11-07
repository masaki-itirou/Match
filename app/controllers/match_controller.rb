class MatchController < ApplicationController
  
  include ConcernMatch
  
  def show
    own = get_own || (render nothing:true and return)
    @id_word_hash,@user_ary = nil,nil
    if Time.parse(own.result_valid_time) > Time.now.utc
      @id_word_hash = YAML.load(own.search_result)
      @user_ary = get_sorted_user(@id_word_hash.keys,params[:page].to_i || 0)      
    else      
      UsingLog.match_num += 1
      @user_ary,@id_word_hash = get_match_user(own,params[:page].to_i || 0)      
    end
    
    respond_to do |format|
      format.js      
      format.html      
    end
  end
  
=begin
タイムアウトをつけたバージョン。
動作確認はしたがタイムアウトさせる意味が不明に思えたのでコメントアウト   

  def show    
    own = get_own || (render nothing:true and return)
    @id_word_hash,@user_ary = nil,nil
    th = Thread.fork do
      if Time.parse(own.result_valid_time) > Time.now.utc
        @id_word_hash = YAML.load(own.search_result)
        @user_ary = get_sorted_user(@id_word_hash.keys,params[:page].to_i || 0)      
      else
        
        @user_ary,@id_word_hash = get_match_user(own,params[:page].to_i || 0)      
      end
    end
    if th.join(10)      
      respond_to do |format|
        format.js      
        format.html      
      end
    else
      @type,@text = false,t("match.long_time")
      respond_to do |format|
        format.js {render "message/fadeout"}
        format.html {render "message/text"}
      end
    end
  end
=end  
end
