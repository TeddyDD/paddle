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
	print("game over")