extends Control

@onready var grid = $Background/Margin/VBox/ScrollContainer/GridContainer



var card_numbers = {}
var right_number
var score

func _ready():
	var cards = []
	for i in grid.get_children():
		cards.append(i)
		var button = i.get_children()[0]
		card_numbers[str(i.name)] = button.name
		button.pressed.connect(Callable(self, "_handle_number_clicked").bind(i.name))
		print(button.name)
	right_number = 1
	score = 2

func _handle_number_clicked(card_name):
	var num = card_numbers[card_name].to_int()
	print("number ", num, " touched ", "score: ", score)
	var button = grid.get_node(card_name).get_children()[0]
	
	if right_number == 9: # finished the game
		# print("congratulation")
		button.visible = false # Hide the button
	elif num == right_number: # correct number touched
		score += 2
		right_number += 1
		button.visible = false # Hide the button
	else: # incorrect
		score -= 1
		# print("not correct try again")
		button.modulate = Color(1, 0, 0) # Red color for incorrect choice
		if score <= 0:
			print("Game over")




func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scences/map.tscn")
