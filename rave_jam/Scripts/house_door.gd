extends Node2D


onready var collider = get_node("Area2D/CollisionShape2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func disable():
	collider.disabled = true
	$AnimationPlayer.play("open")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		disable()
