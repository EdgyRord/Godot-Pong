extends KinematicBody2D

var speed : int = 250

var vel : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _input(event):
	if Input.is_action_just_pressed("p2_push_action"):
		$BasicPushv3.activate()


func _physics_process(delta):
	vel.y = 0
	
	if Input.is_action_pressed("p2_up_move"):
		vel.y -= speed
	elif Input.is_action_pressed("p2_down_move"):
		vel.y += speed
	
	move_and_collide(vel*delta)
	

