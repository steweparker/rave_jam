extends Node2D



var end_dialog = Dialogic.start('finish')

func _ready():
	Autoload.restart = false
	end_dialog.connect("timeline_end", self, "_on_end_dialog_end")
	add_child(end_dialog)

func _on_restart_pressed():
	Jazz.stop()
	get_tree().change_scene("res://Scenes/world.tscn")


func _on_end_dialog_end(timeline):
	$CanvasLayer/restart.visible = true
	$CanvasLayer/restart.disabled = false
	$CanvasLayer/final_picture.visible = true
