extends Node2D

export (PackedScene) var Level_1
export (PackedScene) var Level_Menu = load("res://scenes/Menu_Main.tscn")



func _on_start_pressed():
	get_tree().change_scene_to(Level_1)


func _on_level_pressed():
	#get_tree().change_scene_to(Level_Menu)
	#get_tree().change_scene("res://scenes/Menu_Main.tscn")
	get_tree().change_scene_to(Level_Menu)
	#pass


func _on_exit_pressed():
	get_tree().quit()