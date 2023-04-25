extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if len(self.get_overlapping_bodies()) > 1:
		#print(self.get_overlapping_bodies())
		var interactable: Interactable
		for body in self.get_overlapping_bodies():
			if body is Interactable:
				interactable = body
				break
		
		if interactable:
			interactable._interaction(self)
