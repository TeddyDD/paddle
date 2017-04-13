#tool
extends Area2D

export(int, "easy1", "easy2", "medium1", "medium2", "hard") var type = "easy1" setget set_type

var life = 1
var layer
onready var sprite = get_node("sprite")

var types = { \
	"easy1": 1,
	"easy2": 1,
	"medium1": 2,
	"medium2": 2,
	"hard": 3
}

func _ready():
	set_type(type)

func set_type(value):
	if sprite != null:
		sprite.set_animation(types.keys()[value])
	type = value
	_set_life(type)

func _set_life(value):
	life = types[types.keys()[value]]
	
func _on_Block_area_exit( area ):
	if (area.get_name() == "ball"):
		life -= 1
		if life <=0:
			queue_free()
		else: 
			sprite.set_frame(sprite.get_frame() + 1)
