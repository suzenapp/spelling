#tool
extends Node2D

signal key_tapped(key)
signal key_backspace
signal key_left
signal key_right


export(Color) var back_color = Color.white setget set_back_color


func _ready():
	$Background.color = back_color


func set_back_color(color):
	back_color = color
	if is_inside_tree():
		$Background.color = color


func disable_left():
	$Background/LeftArrow.set_disabled()


func disable_right():
	$Background/RightArrow.set_disabled()


func enable_left():
	$Background/LeftArrow.set_enabled()


func enable_right():
	$Background/RightArrow.set_enabled()


func _on_Letter_key_tapped(key):
	emit_signal("key_tapped", key)


func _on_Backspace_key_tapped():
	emit_signal("key_backspace")


func _on_LeftArrow_key_tapped():
	emit_signal("key_left")


func _on_RightArrow_key_tapped():
	emit_signal("key_right")

