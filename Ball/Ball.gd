tool
extends Area2D

export(String, "green", "gray", "red") var color = "green" setget setcolor
export(String, "small", "medium", "big", "mega") var size = "small" setget setsize
export var init_speed = 30
export var max_speed = 50
export (Vector2) var init_pos = null
export (Vector2) var direction = Vector2(1, -1)
export (int) var div_padd_mov_fact = 25
export (float) var max_defl_hit_paddle = 0.35
export (int) var bounce = 0.01

var textures = {
	green = preload("res://Ball/ball_green.png"),
	red = preload("res://Ball/ball_red.png"),
	gray = preload("res://Ball/ball_grey.png")
}

onready var paddle = get_node("../paddle")
onready var speed = init_speed

var _started = false
var _changed = true
var _is_in_paddle = false
var _static_pos
func _ready():
	add_user_signal("_ball_lost")
	connect("_ball_lost",get_node("../"),"_on_ball_lost")
	
	if typeof(init_pos) != 5:
		init_pos = Vector2(paddle.get_pos().x + paddle.width / 2, paddle.get_pos().y+get_node("Sprite").get_region_rect().size.y/2)
	set_pos(init_pos)
	update_all()
	
	_changed = false
	_started = false
	
	set_fixed_process(true)

func _fixed_process(delta):
	if get_tree().is_editor_hint():
		return
	if _started == true:
		var motion = Vector2()
		direction = direction.normalized()
		_is_in_paddle = false
		
		if _changed == true:
			update_all()
		#if bounce from left edge
		if get_pos().x - (get_node("Sprite").get_region_rect().size.x/2) + (direction.x * speed * delta) < 0 and direction.x <= 0:
			direction.x = -direction.x
			direction.y *= 1.5
			bounce()
		# if bounce from right edge
		if get_pos().x + (get_node("Sprite").get_region_rect().size.x/2) + (direction.x * speed * delta) > Global._width and direction.x >= 0:
			direction.x = -direction.x
			direction.y *= 1.5
			bounce()
		# if bounce from top edge
		if get_pos().y - (get_node("Sprite").get_region_rect().size.x/2) - (direction.y * speed * delta) < 0 and direction.y < 0:
			direction.y = -direction.y
			bounce()
		# if fall out of botton edge
		if  get_pos().y + (get_node("Sprite").get_region_rect().size.x/2) + (direction.y * speed * delta) > Global._height:
			speed = init_speed
			_started = false
			emit_signal("_ball_lost")
		
		motion += direction * speed
		
		var o = false
		for i in get_overlapping_areas():
			if i.get_name() == "l1" or i.get_name() == "r2":
				o = true
				break
		
		if o == false:
			set_pos(get_pos() + motion * delta)
		else:
			for i in get_overlapping_areas():
				if i.get_name() == "l1":
					set_pos(Vector2(get_pos().x+((paddle.velocity.x*paddle.speed)*delta + motion.x) * delta, get_pos().y + motion.y * delta))
					break
				if i.get_name() == "r2":
					set_pos(Vector2(get_pos().x+((paddle.velocity.x*paddle.speed)*delta + motion.x) * delta, get_pos().y + motion.y * delta))
					break
	else:
		if Input.is_action_pressed("ui_select"):
			_started = true
			direction = Vector2(1,-1)
		_static_pos = Vector2(paddle.get_pos().x + paddle.width / 2, paddle.get_pos().y-get_node("Sprite").get_region_rect().size.y/2+1)
		set_pos(_static_pos)

func _on_ball_area_enter( area ):
	if area.is_in_group("Paddle"):
		# paddle movement impact
		if paddle.velocity.x != 0:
			direction.x += (paddle.velocity.x * (paddle.speed / div_padd_mov_fact))
		var inpact_x = get_pos().x + ( get_node("Sprite").get_region_rect().size.x / 2 )
		var midle_of_paddle = paddle.get_pos().x + ( (paddle.width) / 2 )
		var ratio =  ( inpact_x - midle_of_paddle ) / ((paddle.width - 4) / 2)
		if area.get_name() == "center" and abs(ratio) >= 0 and abs(ratio) <= 1 and direction.y >= 0:
			direction.y = -direction.y
			if ratio >= 0:
				direction = direction.rotated(-lerp(0,max_defl_hit_paddle,abs(ratio))*PI)
			else:
				direction = direction.rotated(lerp(0,max_defl_hit_paddle,abs(ratio))*PI)
			if direction.y >= 0:
				direction.y = -direction.y
				direction.y -= 0.1
			inc_speed()
		else:
			if area.get_name() == "l1" and direction.x > 0:
				direction = direction.rotated(PI)
				direction.y *=  1.5
			if area.get_name() == "r2" and direction.x < 0:
				direction = direction.rotated(PI)
				direction.y *= 1.5
			if area.get_name() == "l2":
				direction.y = -direction.y
			if area.get_name() == "r1" :
				direction.y = -direction.y
	
	if area.is_in_group("Blocks"):
		if area.get_name() == "body":
			direction.y = -direction.y
			inc_speed()
		if area.get_name() == "l":
			direction.x = -direction.x
		if area.get_name() == "r":
			direction.x = -direction.x

func bounce():
	direction = direction.rotated(rand_range(-bounce*PI,bounce*PI))
	inc_speed()

func inc_speed():
	if speed < max_speed:
		speed = (speed * 1.03)

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
	
	#DEBUG
	var _dbg_shapes = [sh]
	for i in _dbg_shapes:
		var _s = CollisionShape2D.new()
		_s.set_shape(i)
		var _a = Area2D.new()
		add_child(_a)
		_a.add_child(_s)
		
	#\DEBUG
	
	_changed = false
	
