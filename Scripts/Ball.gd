extends KinematicBody2D

var resolution_width : int = ProjectSettings.get_setting("display/window/size/width")
var resolution_height : int = ProjectSettings.get_setting("display/window/size/height")

var vel : Vector2 = Vector2(0,0)
var speed : int = 500
var last_bounce : PhysicsBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	init_signals()
	pass # Replace with function body.
	
func init_signals():
	SignalBus.connect("score_serve", self, "serve")

func _input(event):
	if Input.is_action_just_pressed("serve"):
		serve(0)

func _physics_process(delta):
	var colision_info = move_and_collide(vel*delta)
	if colision_info:
		if colision_info.collider != last_bounce:
			last_bounce = colision_info.collider
			vel = vel.bounce(colision_info.normal)
		

func serve(point):
	#reset velocity nad last_bounce check
	vel = Vector2()
	last_bounce = null
	
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
	vel = direction.normalized() * speed
	
	#vel = Vector2(90, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Zmiana koordynatów na polarne ?
