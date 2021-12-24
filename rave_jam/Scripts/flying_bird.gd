extends Node2D


onready var collider = get_node("Area2D/CollisionShape2D")
onready var points = load("res://Scenes/points.tscn")
onready var world = get_parent().get_parent()
var is_disabled = false
export var yspeed = 250
export var xspeed = 250
export var fly_speed = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	fly_speed = rng.randi_range(75, 100)
	$AnimationPlayer.play("fly")
	$fly.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_disabled:
		position.x += xspeed * delta
		position.y -= yspeed * delta
	else:
		position.x -= fly_speed * delta

func disable():
	var point = points.instance()
	point.position = get_global_mouse_position()
	point.connect("add_points", world, "_add_points")
	world.add_child(point)
	collider.disabled = true
	$AnimationPlayer.play("fly")
	$fly.stop()
	$flap.play()
	self.scale.x = -1
	is_disabled = true
	$Timer.start()
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		disable()


func _on_Timer_timeout():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("sleepwalker"):
		$AnimationPlayer.play("fly")
		$flap.play()
		$flap.play()
		self.scale.x = -1
		is_disabled = true
		$Timer.start()
