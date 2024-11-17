extends MenuButton
var database: SQLite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_popup().id_pressed.connect(menupress)
	database = AutoLoad.database

func menupress(id) -> void:
	#print(id)
	if id == 0:
		print("edit")
	else:
		var ProjectId = self.get_parent().get_parent().tooltip_text
		print("delete")
		print(ProjectId)
		database.delete_rows("ProjectInfo", "id = '" + ProjectId + "'")
		AutoLoad.RefreshHousing.emit()
