extends Button


var simultaneous_scene = preload("res://Levels/2PlayerPong.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
		self.connect("pressed", self, "_add_a_scene_manually")
		

func _add_a_scene_manually():
	# This is like autoloading the scene, only
	# it happens after already loading the main scene.
	get_tree().get_root().add_child(simultaneous_scene)
	self.queue_free()
