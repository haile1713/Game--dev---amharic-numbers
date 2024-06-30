extends GridContainer
func _ready():
	var card_indexes = [1,2,3,4,5,6,7,8,9]
	shuffle(card_indexes) # shuffle the card index
	for i in range(1,10):
		show_num(i,card_indexes) # show all numbers 


func show_num(num:int, card_indexes:Array)->void:
	var numbers = numbers_needed(num) # for more than 1 digits
	var card_name = "Card%d/Button" % card_indexes[num-1]
	var card  = get_node(card_name)
	card.name = str(num)
	var gap = 50
	var shift = 0
	for i in numbers: # for > 1 digits
		var texture_rect = TextureRect.new()
		var number_img = "res://assets/numbers/%d.png" % i
		texture_rect.texture = load(number_img)
		texture_rect.name = str(i)
		texture_rect.position.y += shift
		card.add_child(texture_rect)
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
func shuffle(array):
	var n = array.size()
	while n > 1:
		var k = randi() % n
		n -= 1
		var temp = array[n]
		array[n] = array[k]
		array[k] = temp
