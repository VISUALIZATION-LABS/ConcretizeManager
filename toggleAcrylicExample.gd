extends Button

func _ready() -> void:
	pass

func _on_button_down() -> void:
	$"../AcrylicBlurPanel".visible = ! $"../AcrylicBlurPanel".visible
