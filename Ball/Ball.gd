tool
extends Node2D

export(String, "green", "gray", "red") var color = "green" setget setcolor
export(String, "small", "medium", "big", "mega") var size = "small" setget setsize

var green = preload("res://Ball/ball_green.png")
var red = preload("res://Ball/ball_red.png")
var gray = preload("res://Ball/ball_grey.png")

var dir = Vector2(1,1)
var ppos = Vector2(0,0)
var speed = 65
var _ready = false
var _changed = true


func _ready():
	update_all()
	_changed = false
	set_process(true)
	
func _process(delta):
	if _changed == true:
		update_all()
	if get_tree().is_editor_hint():
		return
	ppos = get_pos()
	if (!(Vector2(ppos + Vector2(dir * speed * Vector2(delta,delta))).x+(get_node(size).get_region_rect().size.x/2)<get_viewport_rect().size.x)):
		dir.x = -dir.x
	if (!(Vector2(ppos + Vector2(dir * speed * Vector2(delta,delta))).x-(get_node(size).get_region_rect().size.x/2)>0)):
		dir.x = -dir.x
	if (!(Vector2(ppos + Vector2(dir * speed * Vector2(delta,delta))).y+(get_node(size).get_region_rect().size.y/2)<get_viewport_rect().size.y)):
		dir.y = -dir.y
	if (!(Vector2(ppos + Vector2(dir * speed * Vector2(delta,delta))).y-(get_node(size).get_region_rect().size.y/2)>0)):
		dir.y = -dir.y
	set_pos(ppos + Vector2(dir * speed * Vector2(delta,delta)))
		
func setcolor(value):
	color = value
	_changed = true

func bounce(area):
	dir.y = -dir.y

func setsize(value):
	size = value
	_changed = true

# call manually in runtime to update ball
func update_all():
	for c in get_children():
		if c == null:
			break
		if c.get_type() == "Sprite": 
			if c.get_name() != size:
				c.get_node("Area2D").set_enable_monitoring(false)
				c.hide()
			if color == "green":
				c.set_texture(green)
			if color == "gray":
				c.set_texture(gray)
			if color == "red":
				c.set_texture(red)
		c.update()
		get_node(size).get_node("Area2D").set_enable_monitoring(true)
		get_node(size).show()
	_changed = false