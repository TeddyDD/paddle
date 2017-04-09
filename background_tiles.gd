extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# random city bg
	var flip = true
	for t in range(8):
		flip = true if randi() % 2 == 1 else false
		set_cell(t, 1, (randi() % 3) + 6, true)
