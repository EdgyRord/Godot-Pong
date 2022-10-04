extends Area2D


var resolution_width : int = ProjectSettings.get_setting("display/window/size/width")

func _on_Goal_body_entered(body):
	if body.position.x > resolution_width/2:
		SignalBus.emit_signal("score_p1")
	else:
		SignalBus.emit_signal("score_p2")
