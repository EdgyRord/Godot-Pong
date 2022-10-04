extends KinematicBody2D

var speed : int = 150

var vel : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	vel.y = 0
	
	if Input.is_action_pressed("p2_up_move"):
		vel.y -= speed
	elif Input.is_action_pressed("p2_down_move"):
		vel.y += speed
	
	move_and_collide(vel*delta)
	

