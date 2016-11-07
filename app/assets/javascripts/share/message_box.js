function message_box_success(message){
	var id = "#message_box_success"; 	
	$(id + "> strong").text(message);				
	$(id).fadeIn(1000);
	$(id).delay(1000).fadeOut(3000);
}

//warningを表示。classはalert-dangerに変更した。
function message_box_warning(message){
	var id ="#message_box_warning";
	$(id+"> strong").text(message);
	$(id).fadeIn(1000);
	$(id).delay(3000).fadeOut(3000);
}