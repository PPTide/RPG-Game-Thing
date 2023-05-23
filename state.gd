extends Node


var characterTalking:bool = false

var game:GameState

var settings:Settings

func save_game():
	var f = FileAccess.open("user://settings.save", FileAccess.WRITE)
	f.store_pascal_string(var_to_str(settings))
	f.close()
	f = FileAccess.open("user://game.save", FileAccess.WRITE)
	f.store_pascal_string(var_to_str(game))
	f.close()

func load_game():
	if FileAccess.file_exists("user://settings.save"):
		var f = FileAccess.open("user://settings.save", FileAccess.READ)
		settings = str_to_var(f.get_pascal_string())
		settings.apply()
		f.close()
	else:
		settings = Settings.new()
		
	if FileAccess.file_exists("user://game.save"):
		var f = FileAccess.open("user://game.save", FileAccess.READ)
		game = str_to_var(f.get_pascal_string())
		f.close()
	else:
		game = GameState.new()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Saving Game")
		save_game()
		get_tree().quit() # default behavior

func _enter_tree():
	print("Loading Game")
	load_game()
