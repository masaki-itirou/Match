/*
$(function(){
　　$(window).on("scroll",function(){
    	var g_flug = true;		
		if(g_flug){
    		g_flug = false;
    		setTimeout(function(){    			
      			console.log(is_scroll_bottom());
      			g_flug = true;
    		},300);
		}
	});

	function is_scroll_bottom() {
		var body = window.document.body;
		var html = window.document.documentElement;
		
		//scrollTop:スクロール量
		//html.scrolHeight:全体の高さ
		//html.clientHeight:		
		//ブラウザ間の問題を吸収
		
		console.log("body.scrollTop:")
		console.log(body.scrollTop)
		console.log("html.scrollTop:")
		console.log(html.scrollTop)	
		console.log("html.scrollHeight:")	
		console.log(html.scrollHeight)
		console.log("html.clientHeight:")	
		console.log(html.clientHeight)
				
		var scrollTop = body.scrollTop || html.scrollTop;
		console.log("result:"); 
		return !(html.scrollHeight - html.clientHeight - scrollTop);		
	}
});
*/
/*
$(function(){
	var ns = "#xtest_";
	var msg = "<script>alert('xss')</script>";	
	//$(ns+"temp").html(msg);	
	//$(ns+"temp").text(f_escape(msg));	
	var input = '" onclick="alert(1)" "';
	$(ns+"temp").text('<a href="/test/'+ f_escape(input) + '">CLICK</a>');	
});

function t_escape(content) { return $('<div />').text(content).html(); };
function f_escape (str) {
  //return str.replace(/[&'`"<>]/g, function(match) {
  	return str.replace(/[&'`"<>]/g, function(match) {
    return {
      '&': '&amp;',
      "'": '&#x27;',
      '`': '&#x60;',
      '"': '&quot;',
      '<': '&lt;',
      '>': '&gt;',
    }[match];
  });
}
*/