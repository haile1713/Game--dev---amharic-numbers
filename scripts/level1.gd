extends Control
@onready var card1 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card1/Button
@onready var card2 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card2/Button
@onready var card3 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card3/Button
@onready var card4 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card4/Button
@onready var card5 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card5/Button
@onready var card6 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card6/Button
@onready var card7 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card7/Button
@onready var card8 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card8/Button
@onready var card9 = $Background/Margin/VBox/ScrollContainer/GridContainer/Card9/Button
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scences/map.tscn")


func _on_button_pressed():
	#just for testing
	get_tree().change_scene_to_file("res://scences/game.tscn")
func test():
	var card_num = 1
	var card_button = "card%d" %card_num
	card1.connect("pressed",Callable(self,"card_button_pressed"))
func card_button_pressed(btn):
	print("hi")
	print(btn.name)
