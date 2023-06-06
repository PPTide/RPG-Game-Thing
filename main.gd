extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Remove the default TileMap node and add the game map
	remove_child($TileMap)
	var map = load(State.game.map).instantiate()
	add_child(map)
	
	# Connect the map_changed signal to the _change_map function
	State.game.map_changed.connect(_change_map)
	
	# Initialize the fade-to-black effect
	$CanvasLayer/Black.show()
	$CanvasLayer/Black.color = Color.TRANSPARENT

# Called when the game map is changed.
func _change_map():
	# Fade to black
	fade_to_black(1)
	
	# Remove the old map and add the new one
	remove_child($TileMap)
	var map = load(State.game.map).instantiate()
	add_child(map)

# Fades the screen to black over a specified time.
func fade_to_black(time:float):
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/Black, "color", Color.BLACK, time/2)
	tween.tween_property($CanvasLayer/Black, "color", Color.TRANSPARENT, time/2)
