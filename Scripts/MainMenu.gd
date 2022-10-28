extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartSingleButton.grab_focus()



func _on_StartSingleButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/2PlayerPong.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
