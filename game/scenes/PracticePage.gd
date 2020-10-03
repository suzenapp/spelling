extends Node2D

signal back_button_pressed


var _showing := false
var _guiding := false

func _ready():
	_update_hud()
	$KeyboardNode.disable_left()
	$KeyboardNode.disable_right()


func do_layout():
	_update_hud()


func _on_BackButton_pressed():
	emit_signal("back_button_pressed")


func _on_KeyboardNode_key_tapped(key):
	var current = Global.get_current()
	var newText = "%s%s" % [$InputBox.text, key]
	var subExpt = current.substr(0, newText.length())
	if current == newText:
		_spak_up()
	if _guiding:
		if newText == subExpt:
			$InputBox.text += key
			Global.set_current_input($InputBox.text)
		else:
			_hint()
	else:
		if $InputBox.text.length() < 22:
			$InputBox.text += key
			Global.set_current_input($InputBox.text)
	_update_hud()


func _on_PeekBox_pressed():
	if !_showing:
		$PeekBox.text = Global.get_current()
		$HintBox.text = Global.get_current()
		$Timer.start()


func _on_Timer_timeout():
	if !_showing:
		$PeekBox.text = ""
		$HintBox.text = ""
		$InputBox.text = Global.get_current_input()
		$InputBox.set("custom_colors/font_color", Color.black)



func _on_KeyboardNode_key_backspace():
	if $InputBox.text.length() > 0:
		$InputBox.text = $InputBox.text.substr(0, $InputBox.text.length() - 1)
		Global.set_current_input($InputBox.text)
	_update_hud()


func _on_KeyboardNode_key_left():
	pass


func _on_KeyboardNode_key_right():
	pass


func _update_hud():
	if _showing:
		$PeekBox.text = Global.get_current()
	#$Hud.text = "%d / %d" % [(Global.get_current_index()  + 1), Global.words_size()]
	$Hud.text = "%d" % [(Global.get_current_index()  + 1)]
	$Hud1.text = "Correct: %d" % [Global.get_correct_count()]
	$Hud2.text = "Total: %d" % [Global.words_size()]
	$InputBox.text = Global.get_current_input()
	if Global.get_current() == $InputBox.text:
		$Check.visible = true
	else:
		$Check.visible = false


func _on_PeekButton_pressed():
	if !_showing:
		_hint()


func _hint():
		$HintBox.text = Global.get_current_input()
		$HintBox.set("custom_colors/font_color", Color.black)
		$InputBox.text = Global.get_current()
		$InputBox.set("custom_colors/font_color", Color.lightgray)		
		$PeekBox.text = Global.get_current()
		$Timer.start()


func _on_PrevButton_pressed():
	Global.dec_current()
	_update_hud()
	_on_PeekButton_pressed()


func _on_NextButton_pressed():
	Global.inc_current()
	_update_hud()
	_on_PeekButton_pressed()


func _on_ShowButton_pressed():
	if _showing:
		_showing = false
		$ShowButton.text = "show"
		$PeekButton.disabled = false
		$PeekBox.text = ""
	else:
		_showing = true
		$ShowButton.text = "hide"
		$PeekButton.disabled = true
	_update_hud()



func _on_GuideButton_pressed():
	if _guiding:
		_guiding = false
		$GuideButton.text = "guide"
	else:
		_guiding = true
		$GuideButton.text = "no guide"
		#$InputBox.text = ""
		#Global.set_current_input($InputBox.text)



func _on_VibrateButton_pressed():
	print("[PRACTICE] BUZZZZZZZ!")
	Input.vibrate_handheld()
	_spak_up()


func _spak_up():
	$Spaks/Particles2D.emitting = true
	$Spaks/SpaksTimer.start()


func _on_SpaksTimer_timeout():
	$Spaks/Particles2D.emitting = false;
