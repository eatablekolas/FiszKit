extends Control

class Fiszka:
	var front: String
	var back: String
	
	func _init(front: String, back: String):
		self.front = front
		self.back = back

var fiszka_data: Fiszka = Fiszka.new("Pojęcie", "Definicja")

func update(on_front: bool, text: String):
	if on_front:
		fiszka_data.front = text
	else:
		fiszka_data.back = text
