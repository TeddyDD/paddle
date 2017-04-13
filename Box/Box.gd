tool
extends Area2D
export(String, "blue","purple","green","red") var type = "red" setget set_type
export(int) var falling_speed = 15
var types = { \
	"blue":Rect2(Vector2(80,112),Vector2(7,7)),
	"purple":Rect2(Vector2(89,112),Vector2(7,7)),
	"green":Rect2(Vector2(89,120),Vector2(7,7)),
	"red":Rect2(Vector2(80,120),Vector2(7,7))
}

var _ready = false
func _ready():
	clear_shapes()
	var co = ConvexPolygonShape2D.new()
	co.set_points(get_node("Collision").get_polygon())
	add_shape(co)
	_ready = true
	set_type(type)
	set_fixed_process(true)
	

func set_type(t):
	if _ready == true:
		get_node("Sprite").set_region_rect(types[t])
	else:
		type = t
func _fixed_process(delta):
	if get_tree().is_editor_hint() == false:
		set_pos(get_pos() + Vector2(0, falling_speed) * delta)
	if get_pos().y - get_node("Sprite").get_region_rect().size.y >= get_viewport_rect().size.y:
		queue_free()