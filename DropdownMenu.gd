extends MenuButton
var database: SQLite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_popup().id_pressed.connect(menupress)
	database = AutoLoad.database
	
func menupress(id) -> void:
	var ProjectHousing = self.get_parent().get_parent()
	var ProjectId = ProjectHousing.tooltip_text
	var ProjectName = ProjectHousing.get_child(0).get_child(0).text
	#print(id)
	var dir = AutoLoad.dir
	if id == 0:
		print("edit")
		print(OS.get_user_data_dir())
		print(AutoLoad.dir.get_directories())
		#directory.remove(name of directory)
		print(AutoLoad.projectdir + "/" + "file_name")
		print(ProjectName)
	else:
		print("delete")
		print(ProjectId)
		database.delete_rows("ProjectInfo", "id = '" + ProjectId + "'")
		AutoLoad.RefreshHousing.emit()
		#Getting all the folders on OS.get_user_data_dir()
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			var path = AutoLoad.projectdir + "/"
			while file_name != "":
				if dir.current_is_dir():
					print("Found directory: " + file_name)
					print(file_name)
					if file_name == ProjectName:
						OS.move_to_trash(path + file_name)
				file_name = dir.get_next()
		else:
			print("An error occurred when trying to access the path.")
