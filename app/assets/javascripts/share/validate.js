var user_validate = (function(){
	//rubyのsendみたいなものがあれば１つで事足りるのだが
	return {
		name:function(name){			
			if(name.length > user_setting.name_length()){
				message_box_warning(I18n.t("user.name_too_long",{length:user_setting.name_length()}));				
				return false;
			}
			if(name.length == 0){
				message_box_warning(I18n.t("user.name_empty"));
				return false;
			}
			return true;
		},
		word:function(word){
			if(word.length > user_setting.word_length()){
				//modalの状態だとmessage_boxが期待どおりに動かないのでコメントアウト		
				//message_box_warning(I18n.t("user.word_too_long",{length:user_setting.word_length()}));
				return false;
			}
			return true;
		},
		contact:function(contact){			
			if(contact.length > user_setting.contact_length()){
				message_box_warning(I18n.t("user.contact_too_long",{length:user_setting.contact_length()}));
				return false;
			}
			return true;
		}
	};
})();


