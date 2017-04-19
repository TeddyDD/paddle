extends Node

var blocks = []
var columns = 8
var rows = 4
onready var block = preload("res://Block/Block.tscn")

func _ready():
	for i in get_children():
		i.queue_free()
	for x in range(columns):
			blocks.append([])
			for y in range(rows):
				blocks[x].append([])
				blocks[x][y] = set_block(x,y, randi() % 5)
func set_block(x,y,type):
	if type != null:
		blocks[x][y] = block.instance()
		blocks[x][y].set_pos(Vector2(x*16,y*columns+3*16))
		blocks[x][y].layer = y
		blocks[x][y].type = type
		add_child(blocks[x][y],true)