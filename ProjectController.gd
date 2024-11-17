extends Control

var database: SQLite
var table_text: Array

func _ready() -> void:
#Funcionalidade de Acesso da Base de dados na aba projeto
	database = AutoLoad.database
	table_text = database.select_rows("ProjectInfo", "id NOT NULL", ["*"])
	if table_text != null:
#Clicar um clone do Housing que esta Invisivel adicionar os dados, adicionar o id no tooltip
		refresh_housings()
	AutoLoad.RefreshHousing.connect(refresh_housings)
	AutoLoad.ProjectClicked.connect(project_clicked)

#cant make it explicitaly return void because it breaks the signal
func refresh_housings() -> void:
	table_text = database.select_rows("ProjectInfo", "id NOT NULL", ["*"])
	#print(table_text)
	var projecthousing = get_node("MarginContainer/Content/ProjectsPanel/VBoxContainer/ProjectHousing")
	var gridsystem = projecthousing.get_parent()
	print(gridsystem.get_children())
	var gridchild = gridsystem.get_children()
	for n in gridchild.size():
		if gridchild[n].name != "ProjectHousing":
			gridchild[n].queue_free()
	for i in table_text.size():
		var clone = projecthousing.duplicate()
		clone.visible = true
		clone.tooltip_text = str(table_text[i]["id"])
		gridsystem.add_child(clone)
		var projectinfo = clone.get_node("ProjectInfo").get_children()
		#print(projectinfo)
		projectinfo[0].text = table_text[i]["name"]
		projectinfo[1].text = table_text[i]["path"]


func project_clicked(id):
	print(id)
	#probably would look something like acessesing the user data custom thing
	#and then finding whatever file we end up using for scenes
	#and then pass it as an argument to concretize itself
	#for now just gonna open concretize
	print(OS.get_data_dir())
	
	var concretizelocal = OS.get_data_dir() + "/Concretize/Installs/Concretize" + "/Concretize-a1.1.exe"
	print(concretizelocal)
	OS.execute_with_pipe(concretizelocal, ["-f"])
	get_tree().quit()

func _on_btn_new_button_down() -> void:
	$MarginContainer/Content/HeaderPanel/NewprojectPopup.visible = true
