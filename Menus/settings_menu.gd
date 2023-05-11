@tool
extends VBoxContainer

@onready var LangSelector:OptionButton = $LangSelector
@onready var ControlsButtonKeyb:Button = $ControlsBtnKeyb
@onready var ControlsButtonContr:Button = $ControlsBtnContr

@onready var Parent:PauseMenu = $".."

var langs:Array[String] = [tr("English"), tr("German")]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_lang()
	LangSelector.item_selected.connect(_lang_selected)
	ControlsButtonKeyb.pressed.connect(_controls_button_keyb_pressed)
	ControlsButtonContr.pressed.connect(_controls_button_contr_pressed)

# Loads the language that is currently used and uses that as the default for the selector Box
func load_lang():
	LangSelector.clear()
	for l in langs:
		LangSelector.add_item(l)
	var lang = TranslationServer.get_locale()
	if lang.begins_with("de"):
		LangSelector.select(1)
	elif lang.begins_with("en"):
		LangSelector.select(0)
	else:
		LangSelector.select(-1)

func _lang_selected(idx: int):
	match idx:
		0:
			State.settings.language = "en"
			TranslationServer.set_locale("en")
		1:
			State.settings.language = "de"
			TranslationServer.set_locale("de")

func _controls_button_contr_pressed():
	Parent.LastScreens.append("Settings")
	hide()
	Parent.ControlsController.show()
	
func _controls_button_keyb_pressed():
	Parent.LastScreens.append("Settings")
	hide()
	Parent.ControlsKeyboard.show()
