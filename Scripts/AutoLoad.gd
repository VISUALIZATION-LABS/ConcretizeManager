extends Node
var database: SQLite
var projectdir: DirAccess
var dir: DirAccess = DirAccess.open(OS.get_user_data_dir())
var packagedir: DirAccess 
var directories 

signal ProjectClicked(id)
signal RefreshHousing()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	directories = dir.get_directories()
	#Be Certain that Package and Projects Directories exist
	print(directories)
	if directories.find("Projects") != -1:
		print("Found Directory Projects")
	else:
		print("Making Directory Projects")
		dir.make_dir("Projects")
	if directories.find("Packages") != -1:
		print("Found Directory Packages")
	else:
		print("Making Directory Packages")
		dir.make_dir("Projects")
	#Opening access to them after we are sure that they exist
	projectdir = DirAccess.open(OS.get_user_data_dir() + "/Projects")
	packagedir = DirAccess.open(OS.get_user_data_dir() + "/Packages")
