extends Node2D

signal tapped
signal added
signal deleted

# 1:Small 2:Medium 3:Large
var _size := 3
var _id := 0

func _ready():
	pass


func set_id(id : int):
	_id = id

var _h3 := 90
var _h2 := 55
var _h1 := 40

var _f33 := 80
var _f32 := 65
var _f31 := 45

var _f23 := 50
var _f22 := 45
var _f21 := 40

var _f13 := 40
var _f12 := 36
var _f11 := 36


func set_large():
	_size = 3
	$WordButton.rect_size.y = _h3
	$DeleteButton.rect_size.y = _h3
	$AddButton.rect_size.y = _h3
	$WordButton.get("custom_fonts/font").size = _f33
	$DeleteButton.get("custom_fonts/font").size = 80
	$AddButton.get("custom_fonts/font").size = 200

func set_medium():
	_size = 2
	$WordButton.rect_size.y = 58
	$DeleteButton.rect_size.y = 58
	$AddButton.rect_size.y = 58
	$WordButton.get("custom_fonts/font").size = 60
	$DeleteButton.get("custom_fonts/font").size = 60
	$AddButton.get("custom_fonts/font").size = 150


func set_small():
	_size = 1
	$WordButton.rect_size.y = 45
	$DeleteButton.rect_size.y = 45
	$AddButton.rect_size.y = 45
	$WordButton.get("custom_fonts/font").size = 40
	$DeleteButton.get("custom_fonts/font").size = 40
	$AddButton.get("custom_fonts/font").size = 100


func set_text(text : String):
	$WordButton.text = text
	$WordButton.disabled = false
	$WordButton.visible = true
	$DeleteButton.disabled = false
	$DeleteButton.visible = true
	$AddButton.disabled = true
	$AddButton.visible = false
	
	var text_len : int = text.length()
	var font_size := 40
	if _size == 3 && text_len < 10:
		font_size = _f33
	elif _size == 3 && text_len < 15:
		font_size = _f32
	elif _size == 3:
		font_size = _f31
	elif _size == 2 && text_len < 10:
		font_size = _f23
	elif _size == 2 && text_len < 15:
		font_size = _f22
	elif _size == 2:
		font_size = _f21
	elif _size == 1 && text_len < 10:
		font_size = _f13
	elif _size == 1 && text_len < 15:
		font_size = _f12
	elif _size == 1:
		font_size = _f11
	$WordButton.get("custom_fonts/font").size = font_size


func set_add():
	$WordButton.text = ""
	$WordButton.disabled = true
	$WordButton.visible = false
	$DeleteButton.disabled = true
	$DeleteButton.visible = false
	$AddButton.disabled = false
	$AddButton.visible = true

func set_off():
	$WordButton.disabled = true
	$WordButton.visible = false
	$DeleteButton.disabled = true
	$DeleteButton.visible = false
	$AddButton.disabled = true
	$AddButton.visible = false


func set_no_delete():
	$DeleteButton.disabled = true
	$DeleteButton.visible = false

	
func _on_WordButton_pressed():
	emit_signal("tapped")


func _on_AddButton_pressed():
	emit_signal("added")


func _on_DeleteButton_pressed():
	emit_signal("deleted")
