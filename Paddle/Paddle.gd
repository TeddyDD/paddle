extends Patch9Frame


var speed = 55
var width = 18

func _ready():
	set_process(true)
	resize(width)
	set_pos(Vector2(floor(get_viewport_rect().end.x/2)-(get_size().x/2), \
	get_viewport_rect().size.y-ceil(get_size().y/2)-10))
	
func resize(w):
	width = w
	self.width = w
	set_size(Vector2((w),get_size().y))
	get_node("Area2D/center").set_polygon(Vector2Array([Vector2(4,1),Vector2(4,6),Vector2(w-4,6),Vector2(w-4,1)]))
	get_node("Area2D/l1").set_polygon(Vector2Array([Vector2(0,1),Vector2(0,6),Vector2(3,7),Vector2(3,0)]))
	get_node("Area2D/l2").set_polygon(Vector2Array([Vector2(3,0),Vector2(3,7),Vector2(4,6),Vector2(4,1)]))
	get_node("Area2D/r2").set_polygon(Vector2Array([Vector2(w-4,1),Vector2(w-4,6),Vector2(w-3,7),Vector2(w-3,0)]))
	get_node("Area2D/r1").set_polygon(Vector2Array([Vector2(w-3,0),Vector2(w-3,7),Vector2(w,6),Vector2(w,1)]))
	
func _process(delta):
	var vpos = get_pos()
	if (Input.is_action_pressed("ui_left")):
		set_pos(Vector2(vpos.x + (-speed * delta),vpos.y))

	if (Input.is_action_pressed("ui_right")):
		set_pos(Vector2(vpos.x + (speed * delta),vpos.y))


#	if (Input.is_action_pressed("ui_left") \
#		and get_pos().x-(speed*delta)-(width/2)>=0):
#		set_pos(Vector2(get_pos().x - (speed * delta),get_pos().y))
#		print(delta)
#	elif (Input.is_action_pressed("ui_right") \
#		and get_pos().x+(speed*delta)+(width/2)<=get_viewport_rect().size.x):
#		set_pos(Vector2(get_pos().x + (speed * delta),get_pos().y))
		set_pos(get_pos() + Vector2(speed * delta,0))
#		print(delta)


