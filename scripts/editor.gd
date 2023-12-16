extends Control

#region Export Variables
@export var main_scene_path: String
@export var fiszka: Control
@export var manager: Control
@export var front_text: TextEdit
@export var back_text: TextEdit
#endregion

#region Signals
func _on_flip_button_pressed():
	fiszka.flip()

func _on_front_text_changed():
	fiszka.change_text(true, front_text.text)
	manager.update(true, front_text.text)

func _on_back_text_changed():
	fiszka.change_text(false, back_text.text)
	manager.update(false, back_text.text)

func _on_close_button_pressed():
	manager.save(Config.autosave_path)
	SceneManager.load_scene(main_scene_path)
#endregion
