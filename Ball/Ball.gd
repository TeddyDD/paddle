tool
extends Node2D

export(String, "green", "grey", "red") var color = "green" setget setcolor
export(String, "small", "medium", "big", "mega") var size = "small" setget setsize

var green = preload("res://Ball/ball_green.png")
var red = preload("res://Ball/ball_red.png")
var grey = preload("res://Ball/ball_grey.png")

var _ready = false

func _ready():
	_ready = true
	update_all()
	
func setcolor(value):
	color = value
	update_all()
	
func setsize(value):
	size = value
	update_all()

# call manually in runtime to update ball
func update_all():
	for c in get_children():
		if c == null:
			continue
		if c.get_type() == "Sprite": 
			if c.get_name() != size:
				c.get_node("Area2D").set_enable_monitoring(false)
				c.hide()
			if color == "green":
				c.set_texture(green)
			if color == "grey":
				c.set_texture(grey)
			if color == "red":
				c.set_texture(red)
		c.update()
		get_node(size).get_node("Area2D").set_enable_monitoring(true)
		get_node(size).show()