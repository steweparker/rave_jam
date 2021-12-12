extends Node2D

signal start_run

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var start_button = get_node("CanvasLayer/Button")
onready var character = get_node("sleepwalker")
var new_dialog = Dialogic.start('start')


# Called when the node enters the scene tree for the first time.
func _ready():
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
	emit_signal("start_run")