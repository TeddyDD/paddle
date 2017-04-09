extends Sprite

onready var start_pos = \
	Vector2(floor(get_viewport_rect().size.x/2), \
	get_viewport_rect().size.y-10)
var speed = 250
var width = 24 #mustn't be fixed!

func _ready():
	set_pos(start_pos)
	set_process(true)

func _process(delta):
	if (Input.is_action_pressed("ui_left") \
		and get_pos().x-(speed*delta)-(width/2)>=0):
		set_pos(Vector2(get_pos().x-(speed*delta),get_pos().y))
	if (Input.is_action_pressed("ui_right") \
		and get_pos().x+(speed*delta)+(width/2)<=get_viewport_rect().size.x):
		set_pos(Vector2(get_pos().x+(speed*delta),get_pos().y))