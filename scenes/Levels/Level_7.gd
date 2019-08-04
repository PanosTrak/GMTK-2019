extends Node2D

export var Checkpoints = 3
export var Name = "Level"

var hud

func _ready():
	hud = get_child(0)
	hud.setName(Name)
	hud.setScoreMax(Checkpoints)