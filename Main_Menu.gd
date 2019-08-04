extends CanvasLayer

export (PackedScene) var Level_1
export (PackedScene) var Level_2
export (PackedScene) var Level_3
export (PackedScene) var Level_4
export (PackedScene) var Level_5
export (PackedScene) var Level_6
export (PackedScene) var Level_7
export (PackedScene) var Level_8




func _on_start_pressed():
	get_tree().change_scene_to(Level_1)


func _on_level_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()


