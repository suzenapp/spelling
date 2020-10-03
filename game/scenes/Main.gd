extends Node2D

onready var _page_tween := $PageTween
onready var _practice_result := $MainPage/Results
onready var _test_button := $MainPage/TestButton
onready var _test_result := $MainPage/TestResultLabel 

var _delay := 0.2


func _ready():
	do_layout()


func do_layout():
	_update_results()


func _update_results():
	_practice_result.text = "%d / %d" % [Global.get_correct_count(), Global.words_size()]


func _page_v(page1, page2, up):
	_page_tween.interpolate_property(page1, "position:y", 0, -1 * up * 600, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.interpolate_property(page2, "position:y", up * 600, 0, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.start()


func _page_h(page1, page2, left):
	_page_tween.interpolate_property(page1, "position:x", 0, -1 * left * 1024, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.interpolate_property(page2, "position:x", left * 1024, 0, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	_page_tween.start()

	
func _on_WordListButton_pressed():
	$WordListPage.do_layout()
	_page_v($MainPage, $WordListPage, 1)


func _on_WordListPage_back_button_pressed():
	do_layout()
	_page_v($WordListPage, $MainPage, -1)


func _on_StartButton_pressed():
	$PracticePage.do_layout()
	_page_h($MainPage, $PracticePage, 1)


func _on_PracticePage_back_button_pressed():
	do_layout()
	_page_h($PracticePage, $MainPage, -1)
	_update_results()
