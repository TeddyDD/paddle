tool
extends Area2D

export(int, "easy1", "easy2", "medium1", "medium2", "hard") var type = 0 setget set_type
var life = 1

var _anim_names = ["easy1", "easy2", "medium1", "medium2", "hard"]

func _ready():
	_set_life(type)

func set_type(value):
	get_node("sprite").set_animation(_anim_names[value])
	type = value
	_set_life( type )

func _set_life(value):
	if value < 2:
		life = 1
	elif value < 4:
		life = 2
	else:
		life = 3
	prints(life)
	
func hit():
	pass
	