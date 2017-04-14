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
	set_size(Vector2(w,get_size().y))

	get_node("center").clear_shapes()
	get_node("l1").clear_shapes()
	get_node("r1").clear_shapes()
	get_node("l2").clear_shapes()
	get_node("r2").clear_shapes()
	var center = ConvexPolygonShape2D.new()
	var l1 = ConvexPolygonShape2D.new()
	var r1 = ConvexPolygonShape2D.new()
	var l2 = ConvexPolygonShape2D.new()
	var r2 = ConvexPolygonShape2D.new()
	center.set_points(Vector2Array([Vector2(4,1),Vector2(4,6),Vector2(w-4,6),Vector2(w-4,1)]))
	l1.set_points((Vector2Array([Vector2(0,1),Vector2(0,6),Vector2(1,7),Vector2(2,7),Vector2(2,0),Vector2(1,0)])))
	r1.set_points((Vector2Array([Vector2((w-4)+0,1),Vector2((w-4)+0,6),Vector2((w-4)+1,7),Vector2((w-4)+2,7),Vector2((w-4)+2,0),Vector2((w-4)+1,0)])))
	l2.set_points(Vector2Array([Vector2(2,0),Vector2(2,7),Vector2(3,7),Vector2(4,6),Vector2(4,1),Vector2(3,0)]))
	r2.set_points(Vector2Array([Vector2((w-4)+2,0),Vector2((w-4)+2,7),Vector2((w-4)+3,7),Vector2((w-4)+4,6),Vector2((w-4)+4,1),Vector2((w-4)+3,0)]))
	get_node("center").add_shape(center)
	get_node("l1").add_shape(l1)
	get_node("r1").add_shape(r1)
	get_node("l2").add_shape(l2)
	get_node("r2").add_shape(r2)
	
	_prev_width = w
	
func _process(delta):
	if width != _prev_width:
		resize(width)
		
	if Input.is_action_pressed("ui_left") and get_pos().x > 0:
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right") and get_pos().x + width < get_viewport_rect().size.width:
		velocity.x =  speed
	else:
		velocity.x = 0
	
	var motion = velocity * delta
	motion.x = round(motion.x)
	
	set_pos(get_pos() + motion)
	
