extends Control

var projecthousing: Panel 
var gridsystem: VBoxContainer
var database: SQLite
var table_text: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = AutoLoad.database
	table_text = database.select_rows("ProjectInfo", "id NOT NULL", ["*"])
	print(table_text)
	projecthousing = get_node("MarginContainer/Content/ProjectsPanel/VBoxContainer/ProjectHousing")
	print(projecthousing.visible)
	gridsystem = projecthousing.get_parent()
	print(gridsystem.get_child_count())
	
	var clone = projecthousing.duplicate()
	clone.visible = true
	gridsystem.add_child(clone)
	var projectinfo = clone.get_node("ProjectInfo").get_children()
	print(projectinfo)
	projectinfo[0].text = table_text[0]["name"]
	projectinfo[1].text = table_text[0]["path"]
	
	#HIDE ID OF THE HOUSING ON ITS TOOLTIP ITS SO GENIOUS



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_new_button_down() -> void:
	print(database.query("SELECT * FROM Accounts"))
