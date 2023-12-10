extends Label

@export var min_font_size: int = 1
@export var max_len: int = 5

var default_font_size: int

func _ready():
	default_font_size = get_theme_font_size("font_size")

func update_font_size():
	var text_len: int = len(text)
	
	if text_len <= max_len:
		add_theme_font_size_override("font_size", default_font_size)
		return
	
	var new_font_size: int = (float(max_len) / text_len) * default_font_size
	new_font_size = min_font_size if new_font_size < min_font_size else new_font_size
	add_theme_font_size_override("font_size", new_font_size)
