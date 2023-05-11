extends Object
class_name Settings

@export var language:String = TranslationServer.get_locale()

@export var binds:Dictionary

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

func update_binds():
	for action in InputMap.get_actions():
		binds[action] = InputMap.action_get_events(action)
