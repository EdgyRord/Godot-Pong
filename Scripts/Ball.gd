extends KinematicBody2D

var resolution_width : int = ProjectSettings.get_setting("display/window/size/width")
var resolution_height : int = ProjectSettings.get_setting("display/window/size/height")

var vel : Vector2 = Vector2(0,0)
var vel_before_bounce = Vector2(0,0)
var speed : int = 500
var min_speed : int = 500
var last_bounce : PhysicsBody2D = null
var ability_check : int = 0

var debug_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	init_signals()
	set_process(true)
	pass # Replace with function body.
	
func init_signals():
	SignalBus.connect("score_serve", self, "serve")

func _input(event):
	if Input.is_action_just_pressed("serve"):
		serve(0)
	if Input.is_action_just_pressed("debug_ball"):
		debug_mode = !debug_mode
		

func _physics_process(delta):
	if debug_mode:
		position = get_global_mouse_position()
		pass
	else:
		var colision_info = move_and_collide(vel*speed*delta)
		if colision_info:
			last_bounce = colision_info.collider
			#collision with ability
			if last_bounce.get_collision_layer_bit(4):
				vel = vel.bounce(colision_info.normal)
				pass
			#collision with player/wall - usual bounce
			else:
				vel_before_bounce = vel
				var motion = colision_info.remainder.bounce(colision_info.normal)
				vel = vel.bounce(colision_info.normal)
				move_and_collide(motion)
			
		#Reduce speed if too fast TBD	
		if speed > min_speed:
			speed -= 25

func _draw():
	draw_forward_vector()
	pass

func  serve(point):
	#reset velocity nad last_bounce check
	vel = Vector2()
	last_bounce = null
	ability_check = 0
	speed = min_speed
	
	#set variable for x direction and y direction of the ball
	var dir_x = 0
	var dir_y = 0
	
	#set position
	match (point):
		#Starting play
		0:
			position = Vector2(resolution_width / 2, resolution_height / 2)
			dir_x = rand_range(-1,1)
			dir_y = rand_range(-1,1)
		#First player scores
		1:
			position = Vector2(resolution_width / 4 * 3, resolution_height / 2)
			dir_x = rand_range(-1,0)
			dir_y = rand_range(-1,1)
		#Second player scores
		2:
			position = Vector2(resolution_width / 4, resolution_height / 2)
			dir_x = rand_range(0,1)
			dir_y = rand_range(-1,1)

	var direction = Vector2(dir_x, dir_y)
	vel = direction.normalized()

func draw_forward_vector():
	draw_line(Vector2(0,0), Vector2(100,100) * vel,Color.chartreuse,3.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

