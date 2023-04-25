extends NPC

var isInteracting:bool = false

@export var dialogue_resource: DialogueResource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _interaction(_player):
	if isInteracting:
		return
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_example_dialogue_balloon(dialogue_resource)
	isInteracting = true

func _on_dialogue_ended(dialogue_resource):
	isInteracting = false
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
