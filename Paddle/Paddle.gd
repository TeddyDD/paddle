tool
extends Patch9Frame

var speed = 55
export(int) var width = 18
var _prev_width = width

#priv
var vpos = Vector2(0,0)
func _ready():
	set_process(true)
	resize(width)
	set_pos(Vector2(floor(get_viewport_rect().end.x/2)-(get_size().x/2), \
	get_viewport_rect().size.y-ceil(get_size().y/2)-10))

func resize(w):
	width = w
	set_size(Vector2((w),get_size().y))
	get_node("Area2D/center").set_polygon(Vector2Array([Vector2(4,1),Vector2(4,6),Vector2(w-4,6),Vector2(w-4,1)]))
	get_node("Area2D/l1").set_polygon(Vector2Array([Vector2(0,1),Vector2(0,6),Vector2(3,7),Vector2(3,0)]))
	get_node("Area2D/l2").set_polygon(Vector2Array([Vector2(3,0),Vector2(3,7),Vector2(4,6),Vector2(4,1)]))
	get_node("Area2D/r2").set_polygon(Vector2Array([Vector2(w-4,1),Vector2(w-4,6),Vector2(w-3,7),Vector2(w-3,0)]))
	get_node("Area2D/r1").set_polygon(Vector2Array([Vector2(w-3,0),Vector2(w-3,7),Vector2(w,6),Vector2(w,1)]))
	
func _process(delta):
	if width != _prev_width:
		resize(width)
		_prev_width = width
	vpos = get_pos()
	
	if ((Input.is_action_pressed("ui_left")) and (vpos.x-(speed*delta)>=0)):
		vpos.x = round(vpos.x - (speed * delta))
	if ((Input.is_action_pressed("ui_right")) and (vpos.x+(speed*delta)+(width)<=get_viewport_rect().size.x)):
		vpos.x = round(vpos.x + (speed * delta))
		
	set_pos(vpos)
	
func _on_Area2D_area_enter( area ):
	if (get_node("Area2D").get_overlapping_areas().has(get_node("../ball/mega/Area2D"))):
		get_node("../ball").bounce(area)
