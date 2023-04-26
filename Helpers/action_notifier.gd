extends Actionable

class_name ActionNotifier

signal ActionNotify

func action()->void:
	if not interaction_active:
		super.action()
		ActionNotify.emit()
