extends Node2D


var main_scene = preload("res://Scenes/world.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _input(event):
	


func _on_set_locale_toggled(button_pressed):
	if button_pressed:
		set_lang("ru")
	else:
		set_lang("en")


func set_lang(lang):
	TranslationServer.set_locale(lang)
	$CanvasLayer/set_locale.text = lang


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene("res://Scenes/world.tscn")
