extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hit = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = false
	pass # Replace with function body.


func _draw():
	draw_line($CollisionShape2D/Center.position, hit, Color.aqua)

func _process(delta):
	update()


func _on_BasicPushv3_body_entered(body):
	#Get collision point in area 2d
	hit= $CollisionShape2D/Center.position + (body.position - $CollisionShape2D/Center.global_position)
	body.vel = (hit - $CollisionShape2D/Center.position).normalized()
	
func activate():
	if !monitoring:
		monitoring = true
		yield(get_tree().create_timer(1), "timeout")
		monitoring = false

	
