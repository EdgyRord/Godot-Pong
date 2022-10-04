extends KinematicBody2D

var resolution_width : int = ProjectSettings.get_setting("display/window/size/width")
var resolution_height : int = ProjectSettings.get_setting("display/window/size/height")

var vel : Vector2 = Vector2(0,0)
var speed : int = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	init_signals()
	pass # Replace with function body.
	
func init_signals():
	SignalBus.connect("score_serve", self, "serve")

func _input(event):
	if Input.is_action_just_pressed("serve"):
		vel = Vector2()
		position = Vector2(resolution_width / 2, resolution_height / 2)
		var dir_x = rand_range(-1,1)
		var dir_y = rand_range(-1,1)
		var direction = Vector2(dir_x, dir_y)
		vel = direction * speed

func _physics_process(delta):
	var colision_info = move_and_collide(vel*delta)
	if colision_info:
		vel = vel.bounce(colision_info.normal)
		
func serve():
	vel = Vector2()
	position = Vector2(resolution_width / 2, resolution_height / 2)
	var dir_x = rand_range(-1,1)
	var dir_y = rand_range(-1,1)
	var direction = Vector2(dir_x, dir_y)
	vel = direction * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
