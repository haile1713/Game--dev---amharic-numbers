extends Control
@onready var grid  = $Background/Margin/VBox/ScrollContainer/GridContainer
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scences/map.tscn")
var card_numbers = {}
var right_number;
func _ready():
	var cards = []
	for i in grid.get_children():
		cards.append(i)
		var button = i.get_children()[0]
		card_numbers[str(i.name)] = button.name
		print(button.name)
	right_number = 1

func _handle_number_clicked(card):
	var num = card_numbers[card]
	print("number ",num, " touched ")
	#if(num == right_number):
		#right_number+=1
	#else:
		#print("game over")
