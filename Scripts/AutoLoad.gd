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
	#Be Certain that the Directories exist
	print(directories)
	if directories.find("Projects") != -1:
		print("Found Projects")
	else:
		print("Making Directory Projects")
		dir.make_dir(OS.get_user_data_dir() + "/Projects")
	if directories.find("Installs") != -1:
		print("Found Installs")
	else:
		print("Making Directory Installs")
		dir.make_dir(OS.get_user_data_dir() + "/Installs")
	if directories.find("Packages") != -1:
		print("Found Packages")
	else:
		print("Making Directory Packages")
		dir.make_dir(OS.get_user_data_dir() + "/Packages")
	if directories.find("Documentation") != -1:
		print("Found Documentation")
	else:
		print("Making Directory Documentation")
		dir.make_dir(OS.get_user_data_dir() + "/Documentation")
	#Opening access to them after we are sure that they exist
	projectdir = DirAccess.open(OS.get_user_data_dir() + "/Projects")
	packagedir = DirAccess.open(OS.get_user_data_dir() + "/Packages")
