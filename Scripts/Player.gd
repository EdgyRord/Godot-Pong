extends KinematicBody2D

var speed : int = 250
var vel : Vector2 = Vector2()

const push_ability = preload("res://Assets/Abilities/BasicPush.tscn")


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	vel.y = 0
	
	if Input.is_action_pressed("p1_up_move"):
		vel.y -= speed
	elif Input.is_action_pressed("p1_down_move"):
		vel.y += speed
	
	if Input.is_action_just_pressed("p1_push_action"):
		use_main_ability(position + Vector2(30,0))
	
	move_and_collide(vel*delta)
	
	

func use_main_ability(pos):
	var push_gust = push_ability.instance().init(1, pos)
	get_parent().add_child(push_gust)
	
