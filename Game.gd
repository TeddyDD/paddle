extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var blocks = []
func _ready():
	randomize()
	for x in range(8):
		blocks.append([])
		for y in range(4):
			blocks[x].append([])
			blocks[x][y] = set_block(x,y)
func set_block(x,y):
	blocks[x][y] = load("res://Block/Block.tscn").instance()
	blocks[x][y].set_pos(Vector2(x*16,y*8+3*16))
	blocks[x][y].layer = y
	blocks[x][y].type = randi() % 5
	add_child(blocks[x][y])