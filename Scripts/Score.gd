extends Control

onready var score_meter = get_node("ScoreLabel")

var p1_points: int = 0
var p2_points: int = 0

func _ready():
	init_signals()

func init_signals() -> void:
	SignalBus.connect("score_p1", self, "score_1")
	SignalBus.connect("score_p2", self, "score_2")

func score_1():
	p1_points += 1
	create_score_text()
	
func score_2():
	p2_points += 1
	create_score_text()
	
func create_score_text():
	var score : String = String(p1_points) + " | " + String(p2_points)
	score_meter.set_text(score)
	SignalBus.emit_signal("score_serve")
