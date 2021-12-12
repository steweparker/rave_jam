extends Area2D


export var speed = 50
var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		position.x += speed*delta
		
func _on_sleepwalker_area_entered(area):
	if area.is_in_group("block"):
		print_debug("STOP!!")

func _on_start():
	# fadein from black modulation animation
	active = true
