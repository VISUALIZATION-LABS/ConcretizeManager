extends HSlider




func _on_value_changed(value: float) -> void:
	$"../AcrylicBlurPanel".material.set_shader_parameter("maxSize", value)	
	pass # Replace with function body.
