extends Control

@onready var grid = $Background/Margin/VBox/ScrollContainer/GridContainer
@onready var score_label = $Background/Margin/VBox/MarginContainer2/score

var card_numbers = {}
var right_number = 1
var score = 2

func _ready():
	initialize_game()

func initialize_game():
	for i in grid.get_children():
		var button = i.get_children()[0]
		card_numbers[str(i.name)] = button.name
		button.pressed.connect(Callable(self, "_handle_number_clicked").bind(i.name))
	score_label.text = "ነጥብ: " + str(score)  # Update score label text

func _handle_number_clicked(card_name):
	var num = card_numbers[card_name].to_int()
	print("Number", num, "touched. Score:", score)
	var button = grid.get_node(card_name).get_children()[0]
	
	if right_number == 9:  # Finished the game
		button.visible = false  # Hide the button
		LevelPassed.emit_signal("level_passed")
		get_tree().change_scene_to_file("res://scences/win.tscn")
	elif num == right_number:  # Correct number touched
		score += 2
		score_label.text = "ነጥብ: " + str(score)  # Update score label text
		right_number += 1
		button.visible = false  # Hide the button
	else:  # Incorrect
		score -= 1
		score_label.text = "ነጥብ: " + str(score)  # Update score label text
		button.modulate = Color(1, 0, 0)  # Red color for incorrect choice
		if score <= 0:
			print("Game over")  # For testing
			get_tree().change_scene("res://scenes/gameover.tscn")

func _on_back_button_pressed():
	get_tree().change_scene("res://scenes/map.tscn")
