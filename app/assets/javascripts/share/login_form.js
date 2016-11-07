$(function(){
	var ns = "#login_form_";
	$(document).on("click",ns+"send_button",function(){
		var seed = $(ns+"data").data("seed");		
		var pass = $(ns+"password").val();
		pass = easy_sha512(pass);
		pass = easy_sha512(seed + pass);
		$.ajax({
			type:"POST",
			url:"/login/check",
			data:{"name":$(ns+"name").val(),
				 "password":pass,
				 "seed":seed}
		});
	});
});
