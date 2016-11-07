$(function(){
	var ns = "#menu_list_";
	$(document).on("click",ns+"edit_word",function(){
		$(ns+"fade").modal("hide");
		$("#user_modal_show_update_word_fade").modal("show");		
	});
	
});
