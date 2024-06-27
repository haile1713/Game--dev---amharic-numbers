extends Control
# it doesn't work don't touch this
func _on_start_button_pressed(): 
	print("start")
	get_tree().change_scene_to_file("res://scences/map.tscn")

func _on_quit_button_pressed():
	print("quit")
	get_tree().quit()
