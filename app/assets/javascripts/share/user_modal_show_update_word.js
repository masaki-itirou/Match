$(function(){
	var ns = "#user_modal_show_update_word_";
	
	$(document).on("show.bs.modal",ns+"fade",function(){
		$.ajax({
			type:"POST",
			url:"/user/send_word",
			success:function(data,dataType){				
				$(ns+"word").val(data);				
				$(ns+"word_length").text($(ns+"word").val().length);		
			}			
		});
	});
	
	$(document).on("keyup paste",ns+"word",function(){		
		$(ns+"word_length").text($(ns+"word").val().length);		
		if(!user_validate.word($(ns+"word").val())){			
			$(ns+"word_length").attr("style","color:red;");
		}else{
			$(ns+"word_length").attr("style","");
		}
	});
	
	$(document).on("ajax:before",ns+"form",function(){
		if(!user_validate.word($(ns+"word").val())){
			return false;						
		}
		$(ns+"fade").modal("hide");						
	});
	
	
	
});
