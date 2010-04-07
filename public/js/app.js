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
});