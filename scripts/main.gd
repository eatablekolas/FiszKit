extends Control

@export var viewer_scene_path: String
@export var editor_scene_path: String

func _on_open_button_pressed():
	SceneManager.load_scene(viewer_scene_path)

func _on_edit_button_pressed():
	SceneManager.load_scene(editor_scene_path)
