extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_green()


func set_green():
	$AnimationPlayer.play("green")
	$Area2D/CollisionShape2D.disabled = false

func set_red():
	$AnimationPlayer.play("red")
	$Area2D/CollisionShape2D.disabled = true


func _on_Area2D_area_entered(area):
	if area.is_in_group("sleepwalker"):
		$brakes.play()

