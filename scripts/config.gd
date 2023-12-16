extends Node

const config_path: String = "user://config.cfg"
const default_config: Dictionary = {
	"autosave_path" : "user://autosave.fk"
}

var config: ConfigFile = ConfigFile.new()
var autosave_path: String = default_config.autosave_path

func set_value(section: String, key: String, value: Variant):
	config.set_value(section, key, value)
	config.save(config_path)

func _ready():
	var err = config.load("user://config.cfg")
	
	if (err == ERR_FILE_NOT_FOUND):
		config.set_value("Saving", "autosave_path", default_config.autosave_path)
		config.save(config_path)
	elif (err == OK):
		autosave_path = config.get_value("Saving", "autosave_path", default_config.autosave_path)
	else:
		push_error("Unexpected error when loading config: %s (Code: %s)" % [error_string(err), err])
