extends Window

signal NovoProjeto(nome, path)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(OS.get_data_dir())
	print(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS))
	print(OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS))
	print(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP))
	print(OS.get_user_data_dir())



func close_window():
	#print($".")
	$".".visible = false
 
func _on_cancelar_button_button_down() -> void:
	close_window()
func _on_close_requested() -> void:
	close_window()

func _on_criar_button_button_down() -> void:
	
	close_window()


func _on_dialog_button_button_down() -> void:
	$FileDialog.visible = true
