extends StaticBody2D

# Exported variables
@export var speed: float
@export_category("Dialog")
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# Node references
@onready var Follower:PathFollow2D = $"../OtherNPCPath/PathFollow2D"
@onready var ActionNotif:ActionNotifier = $ActionNotifier

# Internal state
var paused:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	ActionNotif.ActionNotify.connect(_interact)

# Called when the player interacts with the NPC.
func _interact():
	paused = true
	self.add_to_group("TalkingTo")
	$AnimatedSprite2D.play("default")
	
	if not State.characterTalking:
		State.characterTalking = true
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

# Called when the NPC finishes interacting with the player.
func _interactionFinished():
	self.remove_from_group("TalkingTo")
	paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not paused:
		Follower.progress_ratio += delta * speed
		
		if Follower.progress_ratio > 0.5:
			$AnimatedSprite2D.play("walkLeft")
		else:
			$AnimatedSprite2D.play("walkRight")
	
	position = Follower.global_position
