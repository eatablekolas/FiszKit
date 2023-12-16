extends Control

#region Export Variables
@export var open_dialog: FileDialog
@export var save_dialog: FileDialog
@export var fiszka: Control
@export var counter: Label
@export var prev: Button
@export var next: Button
@export var front: TextEdit
@export var back: TextEdit
#endregion

#region Variables
var default_fiszka_data: Array = ["Pojęcie", "Definicja"]
var cur_fiszka_data: Fiszka = Fiszka.new(default_fiszka_data[0], default_fiszka_data[1])
var cur_fiszka_index: int = 0
var fiszka_array: Array = [cur_fiszka_data]
#endregion

#region UI Updates
func update_arrows():
	prev.disabled = (cur_fiszka_index == 0)
	next.disabled = (cur_fiszka_index == len(fiszka_array) - 1)

func update_counter():
	counter.text = "%s/%s" % [cur_fiszka_index + 1, len(fiszka_array)]

func load_cur_fiszka():
	fiszka.load_fiszka(cur_fiszka_data.front, cur_fiszka_data.back)
	front.text = cur_fiszka_data.front
	back.text = cur_fiszka_data.back

func update_ui():
	update_counter()
	update_arrows()
	load_cur_fiszka()
#endregion

#region Main Functions
func update(on_front: bool, text: String):
	if on_front:
		cur_fiszka_data.front = text
	else:
		cur_fiszka_data.back = text

func open(path: String):
	if !path.ends_with(".fk"):
		return
	
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
	if file == null:
		var err = FileAccess.get_open_error()
		if err != ERR_FILE_NOT_FOUND:
			push_error("Unexpected error when loading file: %s (Code: %s)" % [error_string(err), err])
		
		file.close()
		return
	
	var fiszka_dict_array: Array
	fiszka_dict_array = file.get_var()
	file.close()
	
	fiszka_array.clear()
	for fiszka_dict: Dictionary in fiszka_dict_array:
		fiszka_array.append(Fiszka.new(fiszka_dict.front, fiszka_dict.back))
	
	cur_fiszka_data = fiszka_array[0]
	cur_fiszka_index = 0
	update_ui()

func save(path: String):
	if !path.ends_with(".fk"):
		path = "%s.fk" % path
	
	var fiszka_dict_array: Array = []
	for fiszka_data in fiszka_array:
		fiszka_dict_array.append(fiszka_data.get_dict())
	
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(fiszka_dict_array)

func add():
	cur_fiszka_data = Fiszka.new(default_fiszka_data[0], default_fiszka_data[1])
	fiszka_array.append(cur_fiszka_data)
	cur_fiszka_index = len(fiszka_array) - 1
	
	save(Config.autosave_path)
	update_ui()

func remove():
	fiszka_array.pop_at(cur_fiszka_index)
	cur_fiszka_index -= (1 if cur_fiszka_index > 0 else 0)
	cur_fiszka_data = fiszka_array[cur_fiszka_index]
	
	save(Config.autosave_path)
	update_ui()

func move(to_next: bool):
	cur_fiszka_index += (1 if to_next else -1)
	cur_fiszka_data = fiszka_array[cur_fiszka_index]
	
	save(Config.autosave_path)
	update_ui()
#endregion

#region Signals
func _on_open_button_pressed():
	open_dialog.show()

func _on_save_button_pressed():
	save_dialog.show()

func _on_open_dialog_file_selected(path):
	open(path)

func _on_save_dialog_file_selected(path):
	save(path)

func _on_add_button_pressed():
	add()

func _on_remove_button_pressed():
	remove()

func _on_prev_button_pressed():
	move(false)

func _on_next_button_pressed():
	move(true)
#endregion

func _ready():
	open(Config.autosave_path)
