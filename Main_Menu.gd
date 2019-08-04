extends CanvasLayer

export (PackedScene) var Level_1
export (PackedScene) var Level_Menu



func _on_start_pressed():
	get_tree().change_scene_to(Level_1)


func _on_level_pressed():
	get_tree().change_scene_to(Level_Menu)


func _on_exit_pressed():
	get_tree().quit()


