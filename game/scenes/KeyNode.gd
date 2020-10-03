#tool
extends Node2D

signal key_tapped(key)

export(Color) var back_color = Color.white setget set_back_color
export(Color) var letter_color = Color.black setget set_letter_color
export(String) var letter = "x" setget set_letter
export(Resource) var icon

func _ready():
	_set_letter_color(Color.green)
	$Background.color = back_color
	$Background/Letter.text = letter
	$Background/Letter.icon = icon
	_set_letter_color(letter_color)

func set_back_color(color):
	back_color = color
	if is_inside_tree():
		$Background.color = color

func set_letter_color(color):
	letter_color = color
	if is_inside_tree():
		_set_letter_color(color)
		
func set_letter(text):
	letter = text
	if is_inside_tree():
		$Background/Letter.text = text


func set_disabled():
	$Background.visible = false
	$Background/Letter.disabled = true
	$Background/Letter.visible = false


func set_enabled():
	$Background.visible = true
	$Background/Letter.disabled = false
	$Background/Letter.visible = true


func _on_Letter_pressed():
	emit_signal("key_tapped", letter)

var _delay1 := 0.2
var _delay2 := 0.3


func _set_letter_color(color):
	$Background/Letter.set("custom_colors/font_color", color)
	$Background/Letter.set("custom_colors/font_color_disabled", color)
	$Background/Letter.set("custom_colors/font_color_hover", color)
	$Background/Letter.set("custom_colors/font_color_pressed", color)
	
func _on_Letter_button_down():
	set("z_index", 1)
	#_set_letter_color(Color.red)
	$Tween.interpolate_property($Background, "rect_scale:x", 1, 1.5, _delay1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property($Background, "rect_scale:y", 1, 1.5, _delay1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()


func _on_Letter_button_up():
	#_set_letter_color(Color.green)
	$Tween.stop_all()
	$Tween.interpolate_property($Background, "rect_scale:x", 1.5, 1, _delay2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property($Background, "rect_scale:y", 1.5, 1, _delay2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	set("z_index", 0)
