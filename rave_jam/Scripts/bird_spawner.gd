extends Node2D


var bird = preload("res://Scenes/flying_bird.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_timer():
	var wait = randi() % 3 + 1
	$Timer.wait_time = wait
	$Timer.start()
	
func spawn_bird():
	var new_bird = bird.instance()
	var char_position = get_parent().get_char_pos()
	char_position.x += 320
	char_position.y -= randi() % 100
	new_bird.global_position = char_position
	get_parent().get_node("obstacles").add_child(new_bird)
	set_timer()
	
func _on_Timer_timeout():
	spawn_bird()


func _on_Area2D_area_entered(area):
	if area.is_in_group("sleepwalker"):
		set_timer()
