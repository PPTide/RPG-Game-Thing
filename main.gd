extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var map = load(State.game.map).instantiate()
	add_child(map)
	State.game.map_changed.connect(_change_map)
	$CanvasLayer/Black.show()
	$CanvasLayer/Black.color = Color.TRANSPARENT

func _change_map():
	fade_to_black(2)
	remove_child($TileMap)
	var map = load(State.game.map).instantiate()
	add_child(map)

func fade_to_black(time:float):
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/Black, "color", Color.BLACK, 1)
	tween.tween_property($CanvasLayer/Black, "color", Color.TRANSPARENT, 1)
