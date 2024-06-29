extends Control
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scences/game.tscn")


func _on_button_pressed(btn):
	var level_name = btn.name
	get_tree().change_scene_to_file("res://scences/%s.tscn"%level_name)
	
