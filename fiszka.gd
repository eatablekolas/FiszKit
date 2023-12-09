extends Control

@export var anim_player: AnimationPlayer

var on_front: bool = true

func flip():
	anim_player.play("flip_to_%s" % ("back" if on_front else "front"))
	on_front = !on_front

func _on_front_pressed():
	flip()

func _on_back_pressed():
	flip()
