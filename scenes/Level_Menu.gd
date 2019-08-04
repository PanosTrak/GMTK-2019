extends CanvasLayer

export (PackedScene) var Level_1
export (PackedScene) var Level_2
export (PackedScene) var Level_3
export (PackedScene) var Level_4
export (PackedScene) var Level_5
export (PackedScene) var Level_6
export (PackedScene) var Level_7
export (PackedScene) var Level_8
export (PackedScene) var Main_Menu

func _on_Level_1_Button_pressed():
	get_tree().change_scene_to(Level_1)


func _on_Level_2_Button_pressed():
	get_tree().change_scene_to(Level_2)


func _on_Level_3_Button_pressed():
	get_tree().change_scene_to(Level_3)


func _on_Level_4_Button_pressed():
	get_tree().change_scene_to(Level_4)


func _on_Level_5_Button_pressed():
	get_tree().change_scene_to(Level_5)


func _on_Level_6_Button_pressed():
	get_tree().change_scene_to(Level_6)


func _on_Level_7_Button_pressed():
	get_tree().change_scene_to(Level_7)


func _on_Level_8_Button_pressed():
	get_tree().change_scene_to(Level_8)


func _on_Back_pressed():
	get_tree().change_scene_to(Main_Menu)
