extends Control

@export var front: Button
@export var back: Button
@export var anim_player: AnimationPlayer

var is_front: bool = true

func flip():
	anim_player.play("flip_to_%s" % ("back" if is_front else "front"))
	is_front = !is_front

func _on_front_pressed():
	flip()

func _on_back_pressed():
	flip()

func change_text(on_front: bool, text: String):
	if (on_front):
		front.text = text
	else:
		back.text = text
