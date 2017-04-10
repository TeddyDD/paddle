tool
extends KinematicBody2D

export(int) var speed = 55
export(int) var width = 18
var _prev_width = width
var velocity = Vector2(0,0)
onready var spr = get_node("paddleSprite")

func _ready():
	set_fixed_process(true)
	resize(width)
	set_pos(Vector2(floor(get_viewport_rect().end.x/2)-(spr.get_size().x/2),\
	                get_pos().y))

func resize(w):
	width = w
	spr.set_size(Vector2(w, spr.get_size().y))
	get_node("center").set_polygon(Vector2Array([Vector2(4,1),Vector2(4,6),Vector2(w-4,6),Vector2(w-4,1)]))
	get_node("l1").set_polygon(Vector2Array([Vector2(0,1),Vector2(0,6),Vector2(3,7),Vector2(3,0)]))
	get_node("l2").set_polygon(Vector2Array([Vector2(3,0),Vector2(3,7),Vector2(4,6),Vector2(4,1)]))
	get_node("r2").set_polygon(Vector2Array([Vector2(w-4,1),Vector2(w-4,6),Vector2(w-3,7),Vector2(w-3,0)]))
	get_node("r1").set_polygon(Vector2Array([Vector2(w-3,0),Vector2(w-3,7),Vector2(w,6),Vector2(w,1)]))
	
func _fixed_process(delta):
	if width != _prev_width:
		resize(width)
		_prev_width = width
		
	if (Input.is_action_pressed("ui_left") and (get_pos().x-(speed*delta) >=0 )):
		velocity.x = -speed
	elif (Input.is_action_pressed("ui_right") and (get_pos().x + (speed*delta) + (width) <= get_viewport_rect().size.x)):
		velocity.x =  speed
	else:
		velocity.x = 0
		
	var motion = velocity * delta
	move(motion)
