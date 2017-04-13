tool
extends Area2D

export(String, "green", "gray", "red") var color = "green" setget setcolor
export(String, "small", "medium", "big", "mega") var size = "small" setget setsize

var textures = {
	green = preload("res://Ball/ball_green.png"),
	red = preload("res://Ball/ball_red.png"),
	gray = preload("res://Ball/ball_grey.png")
}

onready var paddle = get_node("../paddle")

var direction = Vector2(1, 1)
var speed = 30
var _changed = true


func _ready():
	update_all()
	_changed = false
	set_fixed_process(true)
	
func _fixed_process(delta):
	if _changed == true:
		update_all()
	if get_tree().is_editor_hint():
		return
	if get_pos().x - (get_node("Sprite").get_region_rect().size.x/2) + (direction.x * delta) < 0 and direction.x <= 0:
		if direction.y >= 0:
			direction = direction.rotated(0.5*PI)
		else:
			direction = direction.rotated(-0.5*PI)
		bounce()
	if get_pos().x + (get_node("Sprite").get_region_rect().size.x/2) + (direction.x * delta) > get_viewport_rect().size.x and direction.x >= 0:
		if direction.y >= 0:
			direction = direction.rotated(-0.5*PI)
		else:
			direction = direction.rotated(0.5*PI)
		bounce()
	if get_pos().y - (get_node("Sprite").get_region_rect().size.x/2) - (direction.y * delta) < 0 or get_pos().y + (get_node("Sprite").get_region_rect().size.x/2) + (direction.y * delta) > get_viewport_rect().size.y:
		direction.y = -direction.y
		bounce()
	var motion = Vector2()
<<<<<<< Updated upstream
	motion += direction * speed
	set_pos(get_pos() + motion * delta)

=======
	if _started == true:
		motion += direction * speed
		set_pos(get_pos() + motion * delta)
	else:
		set_pos(Vector2(paddle.get_pos().x + paddle.width/2, paddle.get_pos().y-1))
		direction == Vector2(1,-1).normalized()
	if Input.is_action_pressed("ui_select"):
		_started = true
	
>>>>>>> Stashed changes
func _on_ball_area_enter( area ):
	if area.get_name() == "body":
		direction.y = -direction.y
	if area.is_in_group("Paddle"):
		if paddle.velocity.x != 0:
			direction.y = -direction.y
			direction.	x += (paddle.velocity.x / 500)
			direction = direction.normalized()
		else:
			direction.y = -direction.y
		bounce()

#		if area.get_name() == "center":
#			direction = direction.rotated()

	if area.get_name() == "l":
		direction.x = -direction.x
		bounce()
	if area.get_name() == "r":
		direction.x = -direction.x
		bounce()

func bounce():
	direction = direction.rotated(rand_range(-0.02*PI,0.02*PI))
	
func setcolor(value):
	color = value
	_changed = true

func setsize(value):
	size = value
	_changed = true

# call manually in runtime to update ball
func update_all():
	var sh = CircleShape2D.new()
	if size == "small":
		get_node("size_ctrl").play("small")
		clear_shapes()
		sh.set_radius(2)
	elif size == "medium":
		get_node("size_ctrl").play("medium")
		clear_shapes()
		sh.set_radius(2)
	elif size == "big":
		get_node("size_ctrl").play("big")
		clear_shapes()
		sh.set_radius(2.5)
	else:
		get_node("size_ctrl").play("mega")
		clear_shapes()
		sh.set_radius(5)
	get_node("Sprite").set_texture(textures[color])
	add_shape(sh)
	_changed = false
