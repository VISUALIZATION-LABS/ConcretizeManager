extends Node
var database: SQLite
signal ProjectClicked(id)
signal RefreshHousing()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
