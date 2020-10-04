extends Node2D

signal back_button_pressed

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
	if newText == subExpt:
		$InputBox.text += key
		Global.set_current_input($InputBox.text)
	else:
		_hint()
	_update_hud_fields()


func _on_PeekBox_pressed():
	$PeekBox.text = Global.get_current()
	$HintBox.text = Global.get_current()
	$Timer.start()


func _on_Timer_timeout():
	_hint_fields_off()



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
	_hint_fields_off()
	_update_hud_fields()


func _update_hud_fields():
	$Hud.text = "%d" % [(Global.get_current_index()  + 1)]
	$Hud1.text = "Correct: %d" % [Global.get_correct_count()]
	$Hud2.text = "Total: %d" % [Global.words_size()]
	if Global.get_current() == Global.get_current_input():
		$Check.visible = true
	else:
		$Check.visible = false
	if Global.get_correct_count() == Global.words_size():
		$Check2.visible = true
	else:
		$Check2.visible = false


func _on_PeekButton_pressed():
	_hint()


func _hint():
	_hint_fields_on()
	$Timer.start()


func _hint_fields_on():
	$HintBox.text = Global.get_current_input()
	$HintBox.set("custom_colors/font_color", Color.black)
	$InputBox.text = Global.get_current()
	$InputBox.set("custom_colors/font_color", Color.lightgray)		
	$PeekBox.text = Global.get_current()


func _hint_fields_off():
	$PeekBox.text = ""
	$HintBox.text = ""
	$InputBox.text = Global.get_current_input()
	$InputBox.set("custom_colors/font_color", Color.black)


func _on_PrevButton_pressed():
	Global.dec_current()
	_update_hud()
	_on_PeekButton_pressed()


func _on_NextButton_pressed():
	Global.inc_current()
	_update_hud()
	_on_PeekButton_pressed()


func _spak_up():
	$Spaks/Particles2D.emitting = true
	$Spaks/SpaksTimer.start()


func _on_SpaksTimer_timeout():
	$Spaks/Particles2D.emitting = false;
