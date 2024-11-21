extends Node
var database: SQLite
var projectdir: DirAccess
var dir: DirAccess = DirAccess.open(OS.get_user_data_dir())


signal ProjectClicked(id)
signal RefreshHousing()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	projectdir = DirAccess.open(OS.get_user_data_dir() + "/Projects")
