extends Control

var projecthousing: Panel 
var gridsystem: VBoxContainer
var database: SQLite
var table_text: Array

func _ready() -> void:
#Funcionalidade de Acesso da Base de dados na aba projeto
	database = AutoLoad.database
	table_text = database.select_rows("ProjectInfo", "id NOT NULL", ["*"])
	print(table_text)
	if table_text != null:
		projecthousing = get_node("MarginContainer/Content/ProjectsPanel/VBoxContainer/ProjectHousing")
		gridsystem = projecthousing.get_parent()
#Clicar um clone do Housing que esta Invisivel adicionar os dados, adicionar o id no tooltip
		create_new_housing(projecthousing)
	
func create_new_housing(node) -> void:
	for i in table_text.size():
		var clone = node.duplicate()
		clone.visible = true
		clone.tooltip_text = str(table_text[i]["id"])
		gridsystem.add_child(clone)
		var projectinfo = clone.get_node("ProjectInfo").get_children()
		print(projectinfo)
		projectinfo[0].text = table_text[i]["name"]
		projectinfo[1].text = table_text[i]["path"]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_new_button_down() -> void:
	$MarginContainer/Content/HeaderPanel/NewprojectPopup.visible = true
