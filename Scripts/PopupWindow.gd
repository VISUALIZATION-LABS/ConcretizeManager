extends Window

var database: SQLite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#Coloca o folder de abrir como o escolhido por eu e felipe
	$FileDialog.root_subfolder = OS.get_user_data_dir()
	$ProjectPath.text = OS.get_user_data_dir()
	database = AutoLoad.database



func close_window():
	#print($".")
	$".".visible = false
 
func _on_cancelar_button_button_down() -> void:
	close_window()
func _on_close_requested() -> void:
	close_window()
func _on_dialog_button_button_down() -> void:
	$FileDialog.visible = true

func _on_criar_button_button_down() -> void:
	if $ProjectName.text != "":
		var data: Dictionary = {
			"name": $ProjectName.text,
			"path": $ProjectPath.text
		}
		#LINE THAT SENDS THE PROJECT TO THE DATA BASE
		database.insert_row("ProjectInfo", data)
		AutoLoad.RefreshHousing.emit()
		close_window()
		
	else:
		print("else")
		$error.play()



func _on_file_dialog_file_selected(path: String) -> void:
	$ProjectPath.text = path
