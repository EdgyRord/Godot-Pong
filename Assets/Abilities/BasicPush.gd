extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var alive_timer = Timer.new()
var vel = Vector2(0,0)
var scale_up = 0.01
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	alive_timer.connect("timeout", self, "queue_free")
	alive_timer.wait_time = 1
	alive_timer.one_shot = true
	add_child(alive_timer)
	alive_timer.start()
	pass # Replace with function body.
	
	
func _physics_process(delta):
	var colision_info = move_and_collide(vel*delta)
	scale += Vector2(scale_up,scale_up)
	pass


func init(player_number, pos) -> KinematicBody2D:
	position = pos
	scale = Vector2(0.3,0.3)
	match (player_number):
		1:
			rotation_degrees = 90
			position += Vector2(10,0)
			vel.x = speed
		2:
			rotation_degrees = -90
			position -= Vector2(10,0)
			vel.x = -speed
	return self
