extends Node

var blocks = []
var columns = 8
var rows = 4
onready var block = preload("res://Block/Block.tscn")

func _ready():
	randomize()
	for x in range(columns):
		blocks.append([])
		for y in range(rows):
			blocks[x].append([])
			blocks[x][y] = set_block(x,y)

func _on_ball_lost():
	print("game over")

func set_block(x,y):
	blocks[x][y] = block.instance()
	blocks[x][y].set_pos(Vector2(x*16,y*columns+3*16))
	blocks[x][y].layer = y
	blocks[x][y].type = randi() % 5
	add_child(blocks[x][y])