tool
extends Area2D

export(int, "easy1", "easy2", "medium1", "medium2", "hard") var type = 0 setget set_type
var life = 1
var layer
onready var sprite = get_node("sprite")

var _anim_names = ["easy1", "easy2", "medium1", "medium2", "hard"]

func _ready():
	_set_life(type)
	sprite.set_animation(_anim_names[type])

func set_type(value):
	if sprite != null:
		sprite.set_animation(_anim_names[value])
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
	

func _on_Block_area_enter( area ):
	if (area.get_name() == "ball"):
		life -= 1
		if life <=0:
			queue_free()
		else: 
			sprite.set_frame(sprite.get_frame() + 1)
