extends Node2D

var c
export var count = 5
export var dir = Vector2(1, 0)
export var spread = Vector2(64,5)
var people = []


func _ready():
	c = get_colors()
	var head = [c.peach, c.brown, c.yellow]
	var torso = [c.blue, c.red, c.pink, c.orange, c.indigo]
	var pants = [c.dark_blue, c.dark_gray, c.dark_purple]
	for i in range(count):
		var p = Vector2(round(rand_range(-spread.x, spread.x)), \
		                round(rand_range(-spread.y, spread.y)))
		people.append([p, rand_arr(head), rand_arr(torso), rand_arr(pants)])
	
func _draw():
	var ball = get_parent().get_node("ball").get_global_pos()
	for p in people:
		if ball.distance_to(get_global_pos() + p[0]) <= 8:
			draw_rect(Rect2(p[0], Vector2(3,1)), c.red)
			count -= 1
			people.erase(p)
			continue
		var r = Rect2(p[0], Vector2(1,1))
		draw_rect(r, p[1])
		r.pos.y += 1
		draw_rect(r, p[2])
		r.pos.y += 1
		draw_rect(r, p[3])
		
func rand_arr(arr):
	return arr[randi() % arr.size()]
	
func get_colors():
	return {
		# color names form http://www.romanzolotarev.com/pico-8-color-palette/
		black       = Color(0,0,0),
		dark_blue   = Color(0.109804,0.168627,0.32549),
		dark_purple = Color(0.498039,0.141176,0.329412),
		dark_green  = Color(0,0.529412,0.317647),
		brown       = Color(0.670588,0.321569,0.211765),
		dark_gray   = Color(0.376471,0.345098,0.309804),
		light_gray  = Color(0.764706,0.764706,0.776471),
		white       = Color(1,0.945098,0.913725),
		red         = Color(0.929412,0.105882,0.317647),
		orange      = Color(0.980392,0.635294,0.105882),
		yellow      = Color(0.968627,0.92549,0.184314),
		green       = Color(0.364706,0.733333,0.301961),
		blue        = Color(0.317647,0.65098,0.862745),
		indigo      = Color(0.513726,0.462745,0.611765),
		pink        = Color(0.945098,0.462745,0.65098),
		peach       = Color(0.988235,0.8,0.670588),
			}

func _on_move_timeout():
	if count <= 0:
		queue_free()
	if randi() % 4 > 2:
		set_pos( get_pos() + dir)
	for p in people:
		var g = get_global_pos() + p[0]
		if g.x < 0 or g.x > 128:
			people.erase(p)
			count -= 1
			continue
		if g.y < 32:
			p[0].y += 1
		elif g.y > 40:
			p[0].y -= 1
		else:
			p[0] += Vector2(round(rand_range(-1,1)), rand_range(-1,1))
	people.sort_custom(SortPeople, "sort")
	update()

class SortPeople: #lol
	static func sort(a, b):
		if a[0].y < b[0].y:
			return true
		else:
			return false
