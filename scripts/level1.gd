extends Control
@onready var grid  = $Background/Margin/VBox/ScrollContainer/GridContainer
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scences/map.tscn")
var card_numbers = {}
var right_number;
var score
func _ready():
	var cards = []
	for i in grid.get_children():
		cards.append(i)
		var button = i.get_children()[0]
		card_numbers[str(i.name)] = button.name
		print(button.name)
	right_number = 1
	score = 2

func _handle_number_clicked(card):
	var num = card_numbers[card].to_int()
	print("number ",num, " touched ", "score: ", score)
	if(right_number == 9): # finished the game
		print("congradulation")
	elif(num == right_number): # correct number touched
		score+=2
		right_number+=1
	else: # in correct
		score -=1
		print("not correct try again")
		if score <=0:
			print("Game over")
	
