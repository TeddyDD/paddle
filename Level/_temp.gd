extends Node2D

var blocks = []
var columns = 8
var rows = 4
onready var block = preload("res://Block/Block.tscn")
var difficulty = 0
func _ready():
	for i in get_children():
		i.queue_free()
	for x in range(columns):
			blocks.append([])
			for y in range(rows):
				blocks[x].append([])
	set_process(true)
func _process(delta):
	if (floor(get_local_mouse_pos().y/8-7)) >=0 and\
	floor(get_local_mouse_pos().y/8-7) <= rows:
		set_block(floor(get_local_mouse_pos().x/16),floor(get_local_mouse_pos().y/8)-8,0)
func set_block(x,y,type):
	if type != null:
		blocks[x][y] = block.instance()
		blocks[x][y].set_pos(Vector2(x*16,y*8+64))
		blocks[x][y].layer = y
		blocks[x][y].type = type
		add_child(blocks[x][y],true)