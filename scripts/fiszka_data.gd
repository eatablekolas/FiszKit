class_name Fiszka

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
