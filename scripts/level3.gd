extends Control
@onready var grid = $Background/Margin/VBox/ScrollContainer/GridContainer
@onready var score_label =$MarginContainer2/score
@onready var place1 = $"Background/Margin/VBox/MarginContainer/GridContainer/Q-card"
@onready var place2 = $"Background/Margin/VBox/MarginContainer/GridContainer/Q-card2"
@onready var answer = $"Background/Margin/VBox/MarginContainer/GridContainer/Q-card3"
var card_numbers = {}
var right_number
var score = 2
var places = []
var now_at =0
func _ready():
	var cards = []
	places = [place1, place2]
	for i in grid.get_children():
		if i.get_child_count() == 0:
			continue
		cards.append(i)
		var button = i.get_children()[0]
		card_numbers[str(i.name)] = button.name
		button.pressed.connect(Callable(self, "_handle_number_clicked").bind(i.name))
		score_label.text = "ነጥብ:"+ str(score)  # Update score label text		
	right_number = 1
	score = 2
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scences/map.tscn")


func delay_function(delay_time):
	var timer = Timer.new()
	timer.wait_time = delay_time
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "compute_addition"))
	add_child(timer)
	timer.start()


func _handle_num_click(card):
	if(now_at < 1):
		var num = card_numbers[card].to_int()
		show_num(num, places[now_at])
		now_at +=1
	elif now_at == 1:
		var num = card_numbers[card].to_int()
		show_num(num, places[now_at])
		delay_function(1.0)
		

func compute_addition():
	var num1 = (place1.get_children()[0].name).to_int()
	var num2 = (place2.get_children()[0].name).to_int()
	var answer =  answer.get_children()[0].name.to_int()
	print(num1,num2,answer)
	if(num1 - num2 == answer):
		score+=2 # add score
		get_tree().change_scene_to_file("res://scences/win.tscn")
	else:
		score -=1 # incorrect answer
		place1.get_children()[0].texture = null
		place2.get_children()[0].texture = null
	now_at = 0

func show_num(num:int, place)->void:
	var numbers = numbers_needed(num) # for more than 1 digits
	var gap = 50
	var shift = 0
	for i in numbers: # for > 1 digits
		var texture_rect = place.get_children()[0]
		var number_img = "res://assets/numbers/%d.png" % i
		texture_rect.texture = load(number_img)
		texture_rect.name = str(i)
		texture_rect.position.x += shift
		place.add_child(texture_rect)
		shift+=gap
		
func numbers_needed(num:int):
	var dividend:int = num
	var power = 0
	var arr = []
	while dividend != 0:
		var current_power:int = pow(10,power)
		var reminder:int = dividend % 10
		arr.push_front(reminder * current_power)
		dividend = dividend / 10
		power += 1
	return arr

