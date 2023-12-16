extends Control

#region Export Variables
@export var file_dialog: FileDialog
@export var fiszka: Control
@export var counter: Label
@export var prev: Button
@export var next: Button
@export var front: TextEdit
@export var back: TextEdit
#endregion

#region Fiszka Class
class Fiszka:
	var front: String
	var back: String
	
	func _init(front: String, back: String):
		self.front = front
		self.back = back
	
	func get_dict():
		var dict: Dictionary = {
			"front" : front,
			"back" : back
		}
		
		return dict
#endregion

#region Variables
var default_fiszka_data: Array = ["Pojęcie", "Definicja"]
var cur_fiszka_data: Fiszka = Fiszka.new(default_fiszka_data[0], default_fiszka_data[1])
var cur_fiszka_index: int = 0
var fiszka_array: Array = [cur_fiszka_data]
var autosave_path: String = "user://autosave.fk"
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

func save(path: String):
	if !path.ends_with(".fk"):
		path = "%s.fk" % path
	
	var fiszka_dict_array: Array = []
	for fiszka_data in fiszka_array:
		fiszka_dict_array.append(fiszka_data.get_dict())
	
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(fiszka_dict_array)

func add():
	save(autosave_path)
	
	cur_fiszka_data = Fiszka.new(default_fiszka_data[0], default_fiszka_data[1])
	fiszka_array.append(cur_fiszka_data)
	cur_fiszka_index = len(fiszka_array) - 1
	
	update_ui()

func move(to_next: bool):
	save(autosave_path)
	
	cur_fiszka_index += (1 if to_next else -1)
	cur_fiszka_data = fiszka_array[cur_fiszka_index]
	
	update_ui()
#endregion

#region Signals
func _on_save_button_pressed():
	file_dialog.show()

func _on_file_dialog_file_selected(path: String):
	save(path)

func _on_add_button_pressed():
	add()

func _on_prev_button_pressed():
	move(false)

func _on_next_button_pressed():
	move(true)
#endregion
