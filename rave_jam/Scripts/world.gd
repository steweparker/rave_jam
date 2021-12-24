extends Node2D

signal start_run

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var world = load("res://Scenes/world.tscn")
onready var points = load("res://Scenes/points.tscn")
onready var start_button = get_node("CanvasLayer/Button")
onready var color_rect = get_node("CanvasLayer/ColorRect")
onready var character = get_node("sleepwalker")
onready var score_label = get_node("CanvasLayer/MarginContainer/HBoxContainer/Score")
onready var high_score_label = get_node("CanvasLayer/MarginContainer/HBoxContainer/HighScore")
onready var roadlight = get_node("roadlight")
var score = 0 setget set_score, get_score
var new_dialog = Dialogic.start('start')
var help_dialog = Dialogic.start('help')


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/restart_ui.visible = false
	if Autoload.restart:
		$CanvasLayer/MarginContainer.visible = true
		set_score(score)
		high_score_label.text = str(Autoload.get_highscore()) # need to load it from save
		character.connect("wake_up", self, "_game_stop")
		connect("start_run", character, "_on_start")
		$ScoreTimer.start()
		Jazz.play()
		emit_signal("start_run")
	else:
		set_score(score)
		high_score_label.text = str(Autoload.get_highscore()) # need to load it from save
		character.connect("wake_up", self, "_game_stop")
		connect("start_run", character, "_on_start")
		new_dialog.connect("timeline_end", self, "_on_start_dialog_end")
		add_child(new_dialog)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_start_dialog_end(timeline):
	$CanvasLayer/MarginContainer.visible = true
	start_button.visible = true
	color_rect.visible = true

func _on_help_dialog_end(timeline):
	$ScoreTimer.start()
	Jazz.play()
	emit_signal("start_run")

func _on_Button_pressed():
	
	start_button.visible = false
	color_rect.visible = false
	help_dialog.connect("timeline_end", self, "_on_help_dialog_end")
	add_child(help_dialog)
	
	
func set_score(new_score):
	score = new_score
	score_label.text = str(new_score)
	
func get_score():
	return score


func _on_ScoreTimer_timeout():
	var score = get_score() + 5
	set_score(score)

func _game_stop():
	$ScoreTimer.stop()
	if get_score() > Autoload.get_highscore():
		high_score_label.text = str(get_score())
		Autoload.set_highscore(get_score())
	color_rect.visible = true
	$CanvasLayer/restart_ui.visible = true


func _on_camera_follow_area_entered(area):
	var offset_ = $Camera2D.position.x - $sleepwalker.position.x
	$Camera2D.set_player_offset(offset_)
	$Camera2D.active = true
	$camera_follow.queue_free()


func _on_roadlights_button_pressed():
	$Audio/audio_ding.play()
	roadlight.set_red()
	var point = points.instance()
	point.position = get_global_mouse_position()
	point.connect("add_points", self, "_add_points")
	add_child(point)


func _on_restart_button_pressed():
	Autoload.restart = true
	get_tree().change_scene_to(world)


func _on_CanvasAnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene("res://Scenes/Titles.tscn")


func _on_finish_zone_area_entered(area):
	if area.is_in_group("sleepwalker"):
		character.disable_collision()
		$ScoreTimer.stop()
		if get_score() > Autoload.get_highscore():
			high_score_label.text = str(get_score())
			Autoload.set_highscore(get_score())
		$Camera2D.active = false
		$CanvasLayer/CanvasAnimationPlayer.play("fade_out")
		
func _add_points(points):
	var new_score = get_score() + points
	set_score(new_score)
	
func get_char_pos():
	return character.global_position
