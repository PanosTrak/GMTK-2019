extends Node2D

var hud

func _ready():
	hud = get_parent().get_child(0)
	$Label.hide()

func _on_Area2D_area_entered(area):
	var object = area.get_parent()
	if object.is_in_group('player'):
		if hud.win():
			$Label.show()
