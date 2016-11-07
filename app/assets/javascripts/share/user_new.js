$(function(){
	var ns = "#user_new_";	
	$(document).on("click",ns+"send",function(){		
		if(!user_validate.name($(ns+"name").val())){			
			return false;
		}
		if($(ns+"password").val().length == 0){
			return false;
		}
		if($(ns+"password").val() != $(ns+"confirm_password").val()){
			message_box_warning(I18n.t("user.password_mismatch"));			
			return false;			
		}
		$.ajax({
			type:"POST",
			url:"/user/create",
			data:{"name":$(ns+"name").val(),
				  "password":easy_sha512($(ns+"password").val()),
				  "lang":$(ns+"lang").val()}
		});
	});
});
