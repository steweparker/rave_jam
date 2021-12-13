extends Node2D

signal start_run

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var start_button = get_node("CanvasLayer/Button")
onready var character = get_node("sleepwalker")
onready var score_label = get_node("CanvasLayer/MarginContainer/HBoxContainer/Score")
onready var high_score_label = get_node("CanvasLayer/MarginContainer/HBoxContainer/HighScore")
var score = 0 setget set_score, get_score
var new_dialog = Dialogic.start('start')


# Called when the node enters the scene tree for the first time.
func _ready():
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
	start_button.visible = true


func _on_Button_pressed():
	start_button.visible = false
	$ScoreTimer.start()
	emit_signal("start_run")
	
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
	print_debug("Stop!")
