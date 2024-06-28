extends Control
#its ok i fixed it 
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scences/map.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
