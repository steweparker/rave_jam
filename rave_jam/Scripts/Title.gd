extends Node2D


var main_scene = preload("res://Scenes/world.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene("res://Scenes/world.tscn")
