extends Actionable

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func action() -> void:
	if not (interaction_active or State.characterTalking):
		super.action()
		State.characterTalking = true
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
