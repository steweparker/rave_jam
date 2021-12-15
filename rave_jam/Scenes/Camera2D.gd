extends Camera2D





onready var sleepwalker = get_parent().get_node("sleepwalker")
var active = false
var player_offset setget set_player_offset

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		position.x = sleepwalker.position.x + player_offset
		
func set_player_offset(offset_):
	player_offset = offset_
	
