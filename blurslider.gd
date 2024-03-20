extends HSlider




func _on_value_changed(value: float) -> void:
	$"../AcrylicBlurPanel/ColorRect".material.set_shader_parameter("blur", value/10)	
	pass # Replace with function body.
