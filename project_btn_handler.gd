extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_button_down() -> void:
#Used to know what is the id of the project that got clicked
	#print(self.get_parent().tooltip_text)
	AutoLoad.emit_signal("ProjectClicked", self.get_parent().tooltip_text)
