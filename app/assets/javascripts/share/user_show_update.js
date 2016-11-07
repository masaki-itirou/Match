$(function(){
	var ns = "#user_show_update_";
			
	$(document).on("click",ns+"send",function(){
		var data = {};		
		if($(ns+"password").val()){
			if($(ns+"password").val() != $(ns+"confirm_password").val()){
				message_box_warning(I18n.t("user.password_mismatch"));				
				return false;			
			}
			else{
				data["password"] = easy_sha512($(ns+"password").val());
			}				
		}
		if(!user_validate.name($(ns+"name").val())) return false;
		if(!user_validate.contact($(ns+"contact").val())) return false;		
		
		data["name"] = $(ns+"name").val();
		data["contact"] = $(ns+"contact").val();
		data["lang"] = $(ns+"lang").val();
		
		$.ajax({
			type:"POST",
			url:"/user/update",
			data:data				
		});
	});
});
