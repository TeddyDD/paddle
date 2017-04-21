extends Node

var blocks = []
var columns = 8
var rows = 4
onready var block = preload("res://Block/Block.tscn")
var level_queue=[]
var no_level = 0
func _ready():
	randomize()
	var _dir = Directory.new()
	if _dir.open("res://Level")==OK:
		_dir.list_dir_begin()
		var file = _dir.get_next()
		while file !="":
			file = _dir.get_next()
			if (file.begins_with("Level") or file.begins_with("Random")) and  file.ends_with(".gd"):
				level_queue.append(file)
		level_queue.sort_custom(self,"sort_levels")
		_dir.list_dir_end()
		
		print(level_queue)
		load_level("res://Level/"+level_queue[0])

func load_level(path):
	print(get_children())
	if get_children().has("Level"):
		get_node("Level").queue_free()
	var _l = preload("res://Level/Level.tscn").instance()
	_l.set_script(load(path))
	add_child(_l)
	get_node("Level")._ready()

func sort_levels(a,b):
	if b.begins_with("Random"):
		return(true)
	elif a.begins_with("Random"):
		return(false)
	else:
		var as = load("res://Level/"+a)
		var bs = load("res://Level/"+b)
		var oa = Node.new()
		var ob = Node.new()
		oa.set_script(as)
		ob.set_script(bs)
		if oa.difficulty >= ob.difficulty:
			return(true)
		else:
			return(false)

func _on_ball_lost():
	if no_level <= level_queue.size():
		if no_level < level_queue.size()-1:
			no_level += 1
		load_level("res://Level/"+level_queue[no_level])
	for i in get_node("Level").get_children():
		if i.get_name().begins_with("Box"):
			i.queue_free()