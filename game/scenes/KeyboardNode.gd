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

func _input(ev):
	if Input.is_key_pressed(KEY_Q): emit_signal("key_tapped", "q")
	if Input.is_key_pressed(KEY_W): emit_signal("key_tapped", "w")
	if Input.is_key_pressed(KEY_E): emit_signal("key_tapped", "e")
	if Input.is_key_pressed(KEY_R): emit_signal("key_tapped", "r")
	if Input.is_key_pressed(KEY_T): emit_signal("key_tapped", "t")
	if Input.is_key_pressed(KEY_Y): emit_signal("key_tapped", "y")
	if Input.is_key_pressed(KEY_U): emit_signal("key_tapped", "u")
	if Input.is_key_pressed(KEY_I): emit_signal("key_tapped", "i")
	if Input.is_key_pressed(KEY_O): emit_signal("key_tapped", "o")
	if Input.is_key_pressed(KEY_P): emit_signal("key_tapped", "p")
	if Input.is_key_pressed(KEY_A): emit_signal("key_tapped", "a")
	if Input.is_key_pressed(KEY_S): emit_signal("key_tapped", "s")
	if Input.is_key_pressed(KEY_D): emit_signal("key_tapped", "d")
	if Input.is_key_pressed(KEY_F): emit_signal("key_tapped", "f")
	if Input.is_key_pressed(KEY_G): emit_signal("key_tapped", "g")
	if Input.is_key_pressed(KEY_H): emit_signal("key_tapped", "h")
	if Input.is_key_pressed(KEY_J): emit_signal("key_tapped", "j")
	if Input.is_key_pressed(KEY_K): emit_signal("key_tapped", "k")
	if Input.is_key_pressed(KEY_L): emit_signal("key_tapped", "l")
	if Input.is_key_pressed(KEY_Z): emit_signal("key_tapped", "z")
	if Input.is_key_pressed(KEY_X): emit_signal("key_tapped", "x")
	if Input.is_key_pressed(KEY_C): emit_signal("key_tapped", "c")
	if Input.is_key_pressed(KEY_V): emit_signal("key_tapped", "v")
	if Input.is_key_pressed(KEY_B): emit_signal("key_tapped", "b")
	if Input.is_key_pressed(KEY_N): emit_signal("key_tapped", "n")
	if Input.is_key_pressed(KEY_M): emit_signal("key_tapped", "m")
	if Input.is_key_pressed(KEY_LEFT): emit_signal("key_left")
	if Input.is_key_pressed(KEY_RIGHT): emit_signal("key_right")
	if Input.is_key_pressed(KEY_BACKSPACE): emit_signal("key_backspace")

func _on_Letter_key_tapped(key):
	emit_signal("key_tapped", key)


func _on_Backspace_key_tapped(key):
	emit_signal("key_backspace")


func _on_LeftArrow_key_tapped(key):
	emit_signal("key_left")


func _on_RightArrow_key_tapped(key):
	emit_signal("key_right")

