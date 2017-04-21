extends Node

var _width
var _height
var _status = "Game"
func _ready():
	_height = get_viewport().get_rect().size.y
	_width = get_viewport().get_rect().size.x
	set_process_input(true)
func rand_arr(arr):
	return arr[randi() % arr.size()]

func _input(event):
	if Input.is_key_pressed(KEY_F10):
		if _status == "Game":
			_status = "Editor"
			var s = preload("res://Editor.tscn")
			get_node("/root").get_tree().change_scene_to(s)
		elif _status == "Editor":
			_status = "Game"
			var s = preload("res://Game.tscn")
			get_node("/root").get_tree().change_scene_to(s)
