extends VBoxContainer

@onready var LangSelector:OptionButton = $LangSelector

var langs:Array[String] = [tr("English"), tr("German")]

# Called when the node enters the scene tree for the first time.
func _ready():
	load_lang()
	LangSelector.item_selected.connect(_lang_selected)

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
		LangSelector.select(2)

func _lang_selected(idx: int):
	match idx:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("de")
