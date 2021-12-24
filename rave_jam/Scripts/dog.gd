extends Node2D

onready var collider = get_node("Area2D/CollisionShape2D")
onready var points = load("res://Scenes/points.tscn")
onready var world = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


func disable():
	var point = points.instance()
	point.position = get_global_mouse_position()
	point.connect("add_points", world, "_add_points")
	world.add_child(point)
	collider.disabled = true
	$AnimationPlayer.play("hide")
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		disable()

func _on_Area2D_area_entered(area):
	if area.is_in_group("sleepwalker"):
		$AnimationPlayer.play("bark")
