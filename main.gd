extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	_change_map()
	State.game.map_changed.connect(_change_map)

func _change_map():
	remove_child($TileMap)
	var map = load(State.game.map).instantiate()
	add_child(map)
