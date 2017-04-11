tool
extends Patch9Frame

export(int) var speed = 55
export(int) var width = 18
var _prev_width = width
var velocity = Vector2()
onready var _prev_pos = get_pos()

func _ready():
	set_process(true)
	resize(width)
	set_pos(Vector2(floor(get_viewport_rect().end.x/2)-(get_size().x/2),\
	                get_pos().y))

func resize(w):
	width = w
	set_size(Vector2(w,get_size().y))
	get_node("Area2D/center").set_polygon(Vector2Array([Vector2(4,1),Vector2(4,6),Vector2(w-4,6),Vector2(w-4,1)]))
	get_node("Area2D/l1").set_polygon(Vector2Array([Vector2(0,1),Vector2(0,6),Vector2(3,7),Vector2(3,0)]))
	get_node("Area2D/l2").set_polygon(Vector2Array([Vector2(3,0),Vector2(3,7),Vector2(4,6),Vector2(4,1)]))
	get_node("Area2D/r2").set_polygon(Vector2Array([Vector2(w-4,1),Vector2(w-4,6),Vector2(w-3,7),Vector2(w-3,0)]))
	get_node("Area2D/r1").set_polygon(Vector2Array([Vector2(w-3,0),Vector2(w-3,7),Vector2(w,6),Vector2(w,1)]))
	
func _process(delta):
	if width != _prev_width:
		resize(width)
		_prev_width = width
		
	if Input.is_action_pressed("ui_left") and get_pos().x > 0:
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right") and get_pos().x + width < get_viewport_rect().size.width:
		velocity.x =  speed
	else:
		velocity.x = 0
	
	var motion = velocity * delta
	motion.x = round(motion.x)
	
	set_pos(get_pos() + motion)
	
