extends Node2D


export var points = 10

signal add_points(points)
var text = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	text = "+"+str(points)
	$Label.text = text
	emit_signal("add_points", points)
	$AnimationPlayer.play("fade")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
