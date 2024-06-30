extends Control

@onready var grid = $Background/Margin/VBox/ScrollContainer/GridContainer
@onready var score_label =$Background/Margin/VBox/MarginContainer2/score

var card_numbers = {}
var right_number
var score = 2

func _ready():
	var cards = []
	for i in grid.get_children():
		cards.append(i)
		var button = i.get_children()[0]
		card_numbers[str(i.name)] = button.name
		button.pressed.connect(Callable(self, "_handle_number_clicked").bind(i.name))
		score_label.text = "ነጥብ:"+ str(score)  # Update score label text		
	right_number = 1
	score = 2

func _handle_number_clicked(card_name):
	var num = card_numbers[card_name].to_int()
	print("number ", num, " touched ", "score: ", score)
	var button = grid.get_node(card_name).get_children()[0]
	
	if right_number == 9: # finished the game
		button.visible = false # Hide the button
		LevelPassed.emit_signal("level_passed")
		get_tree().change_scene_to_file("res://scences/win.tscn")
	elif num == right_number: # correct number touched
		score += 2
		score_label.text = "ነጥብ:"+ str(score)  # Update score label text
		right_number += 1
		button.visible = false # Hide the button
	else: # incorrect
		score -= 1
		score_label.text = "ነጥብ:" + str(score)  # Update score label text
		button.modulate = Color(1, 0, 0) # Red color for incorrect choice
		if score <= 0:
			print("Game over") #for testing
			get_tree().change_scene_to_file("res://scences/gameover.tscn")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scences/map.tscn")
