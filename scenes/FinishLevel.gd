extends Node2D

func _ready():
	$Label.hide()

func _on_Area2D_area_entered(area):
	var object = area.get_parent()
	if object.is_in_group('player'):
		$Label.show()
