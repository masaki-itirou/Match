$(function(){
	var ns = "#user_delete_button_";
	
	$(document).on("click",ns+"yes",function(){
		$.ajax({
			type:"POST",
			url:"/user/delete"
		});
	});
	
	$(document).on("click",ns+"no",function(){
		$(ns+"modal_fade").modal("hide");
	});
});
