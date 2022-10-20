extends KinematicBody2D


var is_ready = true
var is_shooting = false
var is_returning = false

var origin : int
var current : int
var destination : int

var bumper_distance = 100
var bumper_speed = 2000
var bumper_return_speed = -100


func _ready():
	
# 	Removing lifetime for now
#	alive_timer.connect("timeout", self, "queue_free")
#	alive_timer.wait_time = 1
#	alive_timer.one_shot = true
#	add_child(alive_timer)
#	alive_timer.start()
	
	pass # Replace with function body.
	
	
func _physics_process(delta):
	if is_shooting:
		if current < destination:
			var colision_info = move_and_collide(Vector2(bumper_speed,0)*delta)
			current = get_transform().get_origin().x
			#print_debug("shooting..." + str(current) + " " + str(destination))
		else:
			position.x = 0 + destination
			current = destination
			bumper_wait()
			
	elif is_returning:
		if current > origin:
			var colision_info = move_and_collide(Vector2(bumper_return_speed,0)*delta)
			current = get_transform().get_origin().x
			#print_debug("returning..." + str(current) + " " + str(origin))
		else:
			is_returning = false
			position.x = origin
			is_ready = true


#Shoot the bumper forward
func bumper_shoot(orig):
	print_debug("Shoot bumper")
	is_ready = false
	is_shooting = true
	origin = orig
	current = origin
	destination = origin + bumper_distance
	print_debug(current)
	
func bumper_wait():
	is_shooting = false
	bumper_return()
	
func bumper_return():
	is_returning = true
