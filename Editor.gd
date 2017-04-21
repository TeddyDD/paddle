extends Node

var blocks = []
var columns = 8
var rows = 4
func _ready():
	get_node("Level").set_script(load("res://Level/_temp.gd"))
	get_node("Level")._ready()
