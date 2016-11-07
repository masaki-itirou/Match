var match_show_clo = (function(){	
	var flag = true;
	var timer_id = null;
	return{
		get_flag:function(){return flag;},
		break_flag:function(){flag = false;},
		reset_flag:function(){flag = true;},
		set_timer_id:function(id){timer_id = id;},
		stop_timer:function(){clearInterval(timer_id);} //全ての要素を取得したら、js.erbでstopする。					
	};
})();


$(function(){
	var ns = "#match_show_";	
	var g_page = 0;
	
	if(location.pathname == "/match/show"){
		//一定時間ごとにスクロールがボトムに達しているかチェック。	
		match_show_clo.set_timer_id(setInterval(timer_scroll,1500));   		
	}
	/*	
	スクロールごとに実行=>
	全ての要素を取得してタイマーを止めても再びバインドされてしまうので
	flagの分岐で通信は起きなくてもタイマーだけ動き続けてしまう。
	if(location.pathname == "/match/show"){	
　		$(window).on("scroll",function(){			 	
   		match_show_clo.set_timer_id(setTimeout(timer_scroll,1000));   		
		});
	}
	*/
	function timer_scroll(){		
		if(is_scroll_bottom()){
			if(match_show_clo.get_flag()){
				/*
					フラグの解除(reset_flag)はjs.erbにて行う。
					次に取得出来る要素がもう無い場合はフラグを解除しない。
				*/
				match_show_clo.break_flag();				
				g_page += 1;			
				$.ajax({
     			type:"GET",
     			url:"/match/show",
     			data:{"page":g_page}
     		});
 			}
 		}
	}

});
