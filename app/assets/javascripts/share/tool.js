//matchにはマッチした文字列が入る。
//gは文字列を最後まで走査
//[]はいずれか１つの文字
function r_escape (str) {
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

//最後までスクロールした場合trueを返す。そうでない場合falseを返す。
function is_scroll_bottom() {
		var body = window.document.body;
		var html = window.document.documentElement;
		
		//scrollTop:スクロールされた量
		//html.scrolHeight:全体の高さ
		//html.clientHeight:表示されている画面の高さ
		
		//ブラウザ間の問題を吸収
		var scrollTop = body.scrollTop || html.scrollTop; 
		return !(html.scrollHeight - html.clientHeight - scrollTop);		
}

	/*
	 scrollTopなどの関係はブラウザの画面横に表示されるバーを見れば理解しやすい。
	 全体を枠、ページの上下に伴って枠の中を動くものをバーと呼ぶ。
	 数値は上から０として数えていく。（定規をゼロを上にして立てたイメージ）	 
	 枠の全体の高さ（固定）：html.scrollHeight
	 バーの頂点（スクロールによって変化）：scrollTop
	 バーの長さ（固定）：html.clientHeight
	 */