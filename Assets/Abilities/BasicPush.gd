extends KinematicBody2D


var is_ready = true
var is_shooting = false
var is_returning = false

var origin : int
var origin_y : int
var current : int
var destination : int

var bumper_distance = 100
var bumper_speed = 2000
var bumper_return_speed = -100

var bounce_times : int = 0

func _ready(): 	
	print_debug(get_parent().player_number)
	
	pass # Replace with function body.
	
	
func _physics_process(delta):
	if is_shooting:
		if current < destination:
			var collision_info = move_and_collide(Vector2(bumper_speed,0)*delta)
			if collision_info:
				handle_collision(collision_info.collider)
				bounce_times+= 1
				print_debug(bounce_times)
			current = get_transform().get_origin().x
			#print_debug("shooting..." + str(current) + " " + str(destination))
		else:
			position.x = 0 + destination
			position.y = origin_y
			current = destination
			bumper_wait()
			
	elif is_returning:
		if current > origin:
			var colision_info = move_and_collide(Vector2(bumper_return_speed,0)*delta)
			#handle_collision(colision_info)
			current = get_transform().get_origin().x
			#print_debug("returning..." + str(current) + " " + str(origin))
		else:
			is_returning = false
			position.x = origin
			position.y = origin_y
			#remove_collision_exception_with(collider)
			is_ready = true


func handle_collision(collider):
	collider.speed = 2000 + collider.min_speed
	if(collider.vel_before_bounce.x * collider.vel.x >= 0):
		collider.vel.x = -collider.vel.x
	#add_collision_exception_with(collider)

#Shoot the bumper forward
func bumper_shoot(orig : Vector2):
	print_debug("Shoot bumper")
	is_ready = false
	is_shooting = true
	origin = orig.x
	origin_y = orig.y
	current = origin
	destination = origin + bumper_distance
	print_debug(current)
	
func bumper_wait():
	is_shooting = false
	bumper_return()
	
func bumper_return():
	
	is_returning = true
