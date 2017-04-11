extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var blocks = []
func _ready():
	pass

func set_block():
	blocks.append(load("res:/Block/Block.tscn").new())
	blocks[blocks.size()].set_name("block")
	add_child(blocks[blocks.size()])