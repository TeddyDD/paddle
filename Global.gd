extends Node

var _width
var _height

func _ready():
	_height = get_viewport().get_rect().size.y
	_width = get_viewport().get_rect().size.x
func rand_arr(arr):
	return arr[randi() % arr.size()]