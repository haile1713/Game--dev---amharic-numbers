extends TextureRect

func _ready():
	var rand_num = randi_range(2,9)
	show_num(rand_num)


func show_num(num:int)->void:
	var numbers = numbers_needed(num) # for more than 1 digits
	var gap = 50
	var shift = 0
	print(num)
	for i in numbers: # for > 1 digits
		var texture_rect = get_children()[0]
		var number_img = "res://assets/numbers/%d.png" % i
		texture_rect.texture = load(number_img)
		texture_rect.name = str(i)
		texture_rect.position.x += shift
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

