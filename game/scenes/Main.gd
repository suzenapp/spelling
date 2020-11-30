extends Node2D

onready var _page_tween := $PageTween
onready var _practice_result := $MainPage/Results

var _delay := 0.2
var _confirming := false

func _ready():
	do_layout()


func do_layout():
	_update_results()


func _update_results():
	var total = Global.words_size()
	var correct = Global.get_correct_count()
	if correct == total:
		_practice_result.text = "All correct. Well done!"
		$MainPage/Check.visible = true
	else:
		_practice_result.text = "%d correct out of %d" % [correct, total]
		$MainPage/Check.visible = false


func _page_v(page1, page2, up):
	_page_tween.interpolate_property(page1, "position:y", 0, -1 * up * 600, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.interpolate_property(page2, "position:y", up * 600, 0, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.start()


func _page_h(page1, page2, left):
	_page_tween.interpolate_property(page1, "position:x", 0, -1 * left * 1024, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.interpolate_property(page2, "position:x", left * 1024, 0, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.start()


func _confirm_slide_down():
	if !_confirming:
		_page_tween.interpolate_property($ConfirmSlideDown, "position:y", -300, 0, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
		_page_tween.start()
		_confirming = true

func _confirm_slide_up():
	if _confirming:
		_page_tween.interpolate_property($ConfirmSlideDown, "position:y", 0, -300, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
		_page_tween.start()
		_confirming = false

func _on_WordListButton_pressed():
	_confirm_slide_up()
	$WordListPage.do_layout()
	_page_v($MainPage, $WordListPage, 1)


func _on_WordListPage_back_button_pressed():
	do_layout()
	_page_v($WordListPage, $MainPage, -1)


func _on_StartButton_pressed():
	_confirm_slide_up()
	$PracticePage.do_layout()
	_page_h($MainPage, $PracticePage, 1)


func _on_PracticePage_back_button_pressed():
	do_layout()
	_page_h($PracticePage, $MainPage, -1)
	_update_results()


func _on_ResetPractice_pressed():
	_confirm_slide_down()


func _on_ConfirmOk_pressed():
	_confirm_slide_up()
	Global.clear_expected()
	_update_results()


func _on_ConfirmCancel_pressed():
	_confirm_slide_up()
	
