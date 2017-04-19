extends Node

var blocks = []
var columns = 8
var rows = 4
onready var block = preload("res://Block/Block.tscn")

func _ready():
	randomize()
	get_node("Level").set_script(load("res://Level/Random.gd"))
	get_node("Level")._ready()

func _on_ball_lost():
	for i in get_node("Level").get_children():
		if i.get_name().begins_with("Box"):
			i.queue_free()