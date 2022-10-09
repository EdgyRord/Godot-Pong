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
		serve()

func _physics_process(delta):
	var colision_info = move_and_collide(vel*delta)
	if colision_info:
		print(colision_info.collider)
		if colision_info.collider != last_bounce:
			last_bounce = colision_info.collider
			vel = vel.bounce(colision_info.normal)
		
		
		
		
func serve():
	vel = Vector2()
	last_bounce = null
	position = Vector2(resolution_width / 2, resolution_height / 2)
	var dir_x = rand_range(-1,1)
	var dir_y = rand_range(-1,1)
	var direction = Vector2(dir_x, dir_y)
	vel = direction.normalized() * speed
	
	#vel = Vector2(90, 100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Zmiana koordynatów na polarne ?
