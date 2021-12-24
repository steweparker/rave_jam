extends Node2D


onready var collider = get_node("Area2D/CollisionShape2D")
onready var points = load("res://Scenes/points.tscn")
onready var world = get_parent().get_parent()
var is_disabled = false
export var yspeed = 250
export var xspeed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	var face = randi() %2
	if face == 1:
		self.scale.x = 1
	else:
		self.scale.x = -1
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_disabled:
		position.x += xspeed * delta
		position.y -= yspeed * delta

func disable():
	var point = points.instance()
	point.position = get_global_mouse_position()
	point.connect("add_points", world, "_add_points")
	world.add_child(point)
	collider.disabled = true
	$AnimationPlayer.play("fly")
	$flap.play()
	self.scale.x = -1
	is_disabled = true
	$Timer.start()
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		disable()

func change_pose():
	var i = randi() % 3
	if i == 0:
		$AnimationPlayer.play("idle")
		$AudioStreamPlayer2D.play()
	elif i == 1:
		$AnimationPlayer.play("idle1")
		$AudioStreamPlayer2D.play()
	elif i==2:
		$AnimationPlayer.play("idle2")
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name != "fly":
		change_pose()


func _on_Timer_timeout():
	queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("sleepwalker"):
		$AnimationPlayer.play("fly")
		$flap.play()
		self.scale.x = -1
		is_disabled = true
		$Timer.start()
