extends Object
class_name Settings

@export var language:String = TranslationServer.get_locale()

@export var binds:Dictionary

# Applies the current settings to the game, such as language and input bindings
func apply():
	TranslationServer.set_locale(language)
	for action in InputMap.get_actions():
		InputMap.erase_action(action)
	for action in binds:
		InputMap.add_action(action)
		for event in binds[action]:
			InputMap.action_add_event(action, event)

func _init():
	if binds == null or binds.size() < 1:
		update_binds()

# Updates the input bindings for saving based on the current InputMap
func update_binds():
	for action in InputMap.get_actions():
		binds[action] = InputMap.action_get_events(action)
