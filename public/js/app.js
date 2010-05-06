$.jQTouch({
	icon: 'images/homeicon.png',
	addGlossToIcon: false,
	statusBar: 'black-translucent',
	preloadImages: [
		'themes/jqt/img/chevron_white.png',
		'themes/jqt/img/bg_row_select.gif',
		'themes/jqt/img/back_button_clicked.png',
		'themes/jqt/img/button_clicked.png'
	 ]
});

$(function () {
	$('.reset').click(function (event) {
		event.stopPropagation();
		$('#typed_text').val('');
	});
	
	$('#pandora form ul a, #netflix form ul a').click(function (event) {
		var url = $(this).parents('form').attr('action') + "/" + $(this).attr('rel'),
			elm = $(this);
		event.preventDefault();
		
		elm.addClass('loading');
		$.post(url, {}, function (data, textStatus) {
			elm.removeClass('loading active');
		});
	});
});