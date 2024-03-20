extends Button

signal btnDown(index:int)
@export var windowIndex:int = 0


func _ready() -> void:
	self.pressed.connect(self._button_pressed)
	
func _button_pressed() -> void:
	btnDown.emit(windowIndex)
