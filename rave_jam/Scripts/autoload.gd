extends Node


var highscore = 0 setget set_highscore, get_highscore

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_highscore(new_score):
	highscore = new_score
	
func get_highscore():
	return highscore
