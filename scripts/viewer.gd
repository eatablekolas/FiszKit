extends Control

#region Export Variables
@export var main_scene_path: String
@export var open_dialog: FileDialog
@export var fiszka: Control
@export var counter: Label
@export var prev: Button
@export var next: Button
#endregion

#region Variables
var fiszka_array: Array = []
var fiszka_index: int = 0
#endregion

#region UI Updates
func update_arrows():
	prev.disabled = (fiszka_index == 0)
	next.disabled = (fiszka_index == len(fiszka_array) - 1)

func update_counter():
	counter.text = "%s/%s" % [fiszka_index + 1, len(fiszka_array)]

func load_cur_fiszka():
	var cur_fiszka_data: Fiszka = fiszka_array[fiszka_index]
	fiszka.load_fiszka(cur_fiszka_data.front, cur_fiszka_data.back)

func update_ui():
	update_counter()
	update_arrows()
	load_cur_fiszka()
#endregion

#region Main Functions
func load_fk(path: String):
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var fiszka_dict_array: Array
	fiszka_dict_array = file.get_var()
	file.close()
	
	for fiszka_dict: Dictionary in fiszka_dict_array:
		fiszka_array.append(Fiszka.new(fiszka_dict.front, fiszka_dict.back))
	
	fiszka_index = 0
	update_ui()

func move(to_next: bool):
	fiszka_index += (1 if to_next else -1)
	update_ui()
#endregion

func _ready():
	open_dialog.show()

#region Signals
func _on_open_dialog_file_selected(path):
	load_fk(path)

func _on_flip_button_pressed():
	fiszka.flip()

func _on_prev_button_pressed():
	move(false)

func _on_next_button_pressed():
	move(true)

func _on_close_button_pressed():
	SceneManager.load_scene(main_scene_path)
#endregion
