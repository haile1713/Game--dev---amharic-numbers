extends Node2D

@onready var curve = $"..".curve 
@onready var path_follower = $"../PathFollow2D"
@onready var level_indicator = $"../PathFollow2D/current_level"
# initalization
var current_level = 1

var speed = 0.1
var num_levels = 4
func _ready():
	var level_name = "level-%d" %current_level 
	level_indicator.name = level_name
# utilities
func pass_level():
	if(current_level < num_levels): 
		current_level +=1
		var level_name = "level-%d" %current_level
		level_indicator.name = level_name

func getLevel(path_progress,num_levels):
	var spacing = 1.0/num_levels # spacing of each level from the progress
	var dx = 0.01 # small space if it is not exact
	var start_Level = 0.1 # start from 
	for i in range(num_levels): # increment level
		var current =  i*spacing + start_Level # calculate current level position in %  
		if path_progress > current and path_progress < current+dx: # check if it is in that level
			return i+1
	return -1 # if it is not in any level

# drawing the dotted lines
func _draw():
	var point_count = curve.get_point_count()
	for i in range(1,point_count):
		var point = curve.get_point_position(i)
		if(i%2 == 0): # every two interval
			var point2 = curve.get_point_position(i-1)
			draw_line(point2, point, Color(1,1,1), 5) # connect two point with a line
		var path_progress = i/float(point_count)
		if getLevel(path_progress, num_levels) != -1  and getLevel(path_progress, num_levels) != current_level:
			 # if the progress it at a level which is not the current
			var level = getLevel(path_progress, num_levels)
			var btn = Button.new()
			btn.position=point  + Vector2(-12,-12)
			btn.size=Vector2(24,24)
			btn.flat=true
			btn.name = "level%d"%level
			btn.add_to_group("levels")
			$".".add_child(btn)
			draw_circle(point,12,Color(0.8,0.4,0.2))
	go_to_level_on_button()

func _process(delta):
	path_follower.progress_ratio +=delta*speed # make the icon for the current level go 
	
	var progress = path_follower.progress_ratio
	if getLevel(progress*0.97, num_levels)  == current_level:
		speed = 0
	else:
		speed = 0.1

# go to current level button
func _on_button_pressed():
	var level_name = "res://scences/level%s.tscn"%current_level
	get_tree().change_scene_to_file(level_name)
# level 1 button
func  go_to_level_on_button():
	var levels = get_tree().get_nodes_in_group("levels")
	for i in levels:
		var level = i.name
		i.connect("pressed",go_to_level(level))
func go_to_level(level):
	var change_scene = func ():
		var goto = "res://scences/%s.tscn"%level
		get_tree().change_scene_to_file(goto)
		
	return change_scene
