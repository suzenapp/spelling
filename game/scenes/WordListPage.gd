extends Node2D

export (PackedScene) var Word

signal back_button_pressed

var _delay := 0.2
var _editing := false
var _adding := false
var _edit_index := 0
var _word_nodes := []
var _words := []

func _ready():
	$KeyboardNode.disable_left()
	$KeyboardNode.disable_right()
	for i in range(20):
		var w = Word.instance()
		w.set_id(i)
		w.set_off()
		w.connect("tapped", self, "_word_tapped", [i])
		w.connect("added", self, "_word_added", [i])
		w.connect("deleted", self, "_word_deleted", [i])
		$WordPad.add_child(w)
		_word_nodes.push_back(w)
	do_layout()

var _h3 := 90
var _h2 := 55
var _h1 := 40

func do_layout():
	print("[WORDS] Do Layout..")
	_words = Global.get_words()
	var size = _words.size()

	var col := 5
	var h := _h3
	var g := 4
	var wsize := 3
	
	if size < 10:
		wsize = 3
		col = 5
		g = 4
		h = _h3
	elif size < 15:
		wsize = 2
		col = 8
		g = 9
		h = _h2
	else:
		wsize = 1
		col = 10
		g = 11
		h = _h1
	
	for i in range(col):
		for j in range(2):
			var k = i + (j * col)
			var w = _word_nodes[k]
			if wsize == 3:
				w.set_large()
			elif wsize == 2:
				w.set_medium()
			else:
				w.set_small()
			w.position = Vector2(50 + (j * 524), 80 + (g + h) * i)
			w.set_text("")
	
	
	for i in range(20):
		if i < size:
			_word_nodes[i].set_text(_words[i].expected)
		elif i == size:
			_word_nodes[i].set_add()
		else:
			_word_nodes[i].set_off()
	
	if size == 1:
		_word_nodes[0].set_no_delete()
		_word_nodes[0].position = Vector2(0, 80)


func _word_tapped(id):
	if _editing:
		return
	_edit_index = id
	$TypePad/Label.text = _words[id].expected
	_slide_up()
	print("tapped %d" % [id])


func _word_added(id):
	if _editing:
		return
	_adding = true
	$TypePad/Label.text = ""
	_slide_up()
	print("added %d" % [id])


func _word_deleted(id):
	if _editing:
		return
	Global.delete_word(id)
	do_layout()


func _slide_up():
	_editing = true
	$KeyboardTween.interpolate_property($KeyboardNode, "position:y", 600, 300, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$TypePad.position.x = 0
	$TypePad/Tween.interpolate_property($TypePad, "position:y", -250, 0, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$KeyboardTween.start()
	$TypePad/Tween.start()


func _slide_down():
	$KeyboardTween.interpolate_property($KeyboardNode, "position:y", 300, 600, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$TypePad/Tween.interpolate_property($TypePad, "position:y", 0, -250, _delay, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$KeyboardTween.start()
	$TypePad/Tween.start()
	yield($TypePad/Tween, "tween_completed")
	$TypePad.position.x = 1100
	_editing = false


func _keyboard_up():
	_slide_up()


func _keyboard_down():
	_slide_down()


func _on_BackButton_pressed():
	emit_signal("back_button_pressed")


func _on_TypePadDoneButton_pressed():
	_slide_down()
	if _adding:
		_adding = false
		if $TypePad/Label.text.length() > 0:
			Global.add_word($TypePad/Label.text)
	else:
		if $TypePad/Label.text.length() > 0:
			Global.set_word(_edit_index, $TypePad/Label.text)
		else:
			if _edit_index== 0 && Global.words_size() == 1:
				Global.set_word(_edit_index, "hello")
			else:
				Global.delete_word(_edit_index)

	do_layout()


func _on_KeyboardNode_key_tapped(key):
	if $TypePad/Label.text.length() < 22:
		$TypePad/Label.text += key


func _on_KeyboardNode_key_backspace():
	if $TypePad/Label.text.length() > 0:
		$TypePad/Label.text = $TypePad/Label.text.substr(0, $TypePad/Label.text.length() - 1)


func _on_KeyboardNode_key_left():
	pass # Replace with function body.


func _on_KeyboardNode_key_right():
	pass # Replace with function body.
