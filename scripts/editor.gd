extends "res://scripts/viewer.gd"

@export var manager: Control
@export var front_text: TextEdit
@export var back_text: TextEdit

func _on_front_text_changed():
	fiszka.change_text(true, front_text.text)
	manager.update(true, front_text.text)

func _on_back_text_changed():
	fiszka.change_text(false, back_text.text)
	manager.update(false, back_text.text)
