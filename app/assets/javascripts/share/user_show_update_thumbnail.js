$(function() {
	var ns = "#user_show_update_";
	var g_reader = new FileReader();
	
	//画像を選択後
	$(document).on("change",ns+"image",when_image_change);

	function when_image_change(evt) {
		//画像ファイルを読み込み、表示はajax:successの時のみ行う
		//input fileに入力されたファイルを読み取れるのは、送信前までなので送信前に読み込んでおく必要がある。
		var files = evt.target.files;
		g_reader.readAsDataURL(files[0]);
	}

	//画像の読み込み完了後に、画像を送信する。
	g_reader.onload = function() {
		$(ns + "image_form").trigger("submit");
	};

	//見かけ上のフォームではなく隠しフィールドに画像データを入れて送信している。
	$(document).on("click",ns+"preview", function(){
		$(ns + "image").trigger("click");
	});

	//画像を送信後
	$(document).on("ajax:complete",ns+"image_form",function(){
		//送信完了後、imageタグを交換する。
		//changeイベントが最初の一回の変更（画像ファイル選択）でしか発火しないため
		change_form_tag();
	});

	//画像送信成功後
	$(document).on("ajax:success",ns+"image_form",function(){
		//preiveにイメージを表示
		$(ns + "preview").prop("src", g_reader.result);
	});

	function change_form_tag() {
		//html()は一つ目の子要素のhtmlを返す。その要素ではなく、その子要素のhtmlを返す。
		var tem = $(ns+"image_form").html();
		$(ns + "image").remove();
		$(ns + "image_form").prepend(tem);
		$(ns + "image").prop("disabled", false);
		$(ns + "image").on("change", when_image_change);
	}

});
