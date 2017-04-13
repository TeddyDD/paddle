#tool
extends Area2D

export(int, "easy1", "easy2", "medium1", "medium2", "hard") var type = 0 setget set_type

var life = 1
var layer
onready var sprite = get_node("sprite")
var box = preload("res://Box/Box.tscn")

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
			if rand_range(0,100) <= 15*types[types.keys()[type]]:
				var b = box.instance()
				b.set_type(Global.rand_arr(b.types.keys()))
				b.set_pos(get_pos()+(get_node("sprite").get_item_rect().size/2))
				get_node("../").add_child(b)
			queue_free()
		else: 
			sprite.set_frame(sprite.get_frame() + 1)
