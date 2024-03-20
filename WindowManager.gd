extends Control

func _ready() -> void:
	pass

func getControl(node:Control) -> Array:
		var children:Array = []
		for i in node.get_children():
			children.append(i)
		return children

#TODO: REFACTOR

func _on_btn_install_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[0].visible = true
	
	for i in nodes.size():
		if i != 0:
			nodes[i].visible = false

func _on_btn_pacotes_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[1].visible = true
	
	for i in nodes.size():
		if i != 1:
			nodes[i].visible = false


func _on_btn_conta_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[2].visible = true
	
	for i in nodes.size():
		if i != 2:
			nodes[i].visible = false


func _on_btn_sair_button_down() -> void:
	get_tree().quit()
