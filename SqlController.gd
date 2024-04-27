extends Control

var text: Array
var database: SQLite
func _ready() -> void:
#Inciciação da Tabela e path da tabela
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
#Dados da Tablela = id, email, username, password, type
#Inserir dados da tabela quando a pagina admin é inciada pela primeira vez
	text = _read_table(0)
	for i in text.size():
		print(text[i])
		%OutAdmins.text += "Id: " + str(text[i]['id']) + "\n"
		%OutAdmins.text += "Email: " + text[i]['email'] + "\n"
		%OutAdmins.text += "Nome de Usuario: " + text[i]['username'] + "\n"
		%OutAdmins.text += "Senha: " + str(text[i]['password']) + "\n"
	#Add Options For TypeSelector
	$MarginContainer/Content/DownloadPanel/Control/TypeSelector.add_item("Admin", 0)
	$MarginContainer/Content/DownloadPanel/Control/TypeSelector.add_item("Artist", 1)
	$MarginContainer/Content/DownloadPanel/Control/TypeSelector.add_item("User", 2)
	# Warning Declaration of the options on AccountSelector in WindowManager.gd
	#To use less resources since we already do that there


#Obter dados da tabela e retorna-los sintaxe: "table name", "conditions", "what to get"
#Using workaround to insert value inside string
func _read_table(type) -> Array:
	return database.select_rows("Accounts", "type = %s" % [type], ["*"])


#Funcionalidade das Abas
func _on_tab_container_tab_changed(tab) -> void:
#Limpar as Caixas de Texto todas as vezes que se mudar de aba
	%OutAdmins.set_text("")
	%OutArtists.set_text("")
	%OutUser.set_text("")
#Descobrir qual tabela é Sintaxe: 0 = Admins, 1 = Artistas, 2 = Usuarios
	text = _read_table(tab)
#Utilizar dados do correspondente tipo de acordo com a sintaxe
	match tab:
		0:
			for i in text.size():
				print(text[i])
				%OutAdmins.text += "Id: " + str(text[i]['id']) + "\n"
				%OutAdmins.text += "Email: " + text[i]['email'] + "\n"
				%OutAdmins.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutAdmins.text += "Senha: " + str(text[i]['password']) + "\n"
		1:
			for i in text.size():
				print(text[i])
				%OutArtists.text += "Id: " + str(text[i]['id']) + "\n"
				%OutArtists.text += "Email: " + text[i]['email'] + "\n"
				%OutArtists.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutArtists.text += "Senha: " + str(text[i]['password']) + "\n"
		2:
			for i in text.size():
				print(text[i])
				%OutUser.text += "Id: " + str(text[i]['id']) + "\n"
				%OutUser.text += "Email: " + text[i]['email'] + "\n"
				%OutUser.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutUser.text += "Senha: " + str(text[i]['password']) + "\n"

#Register User Logic
func _on_register_button_button_down() -> void:
#Data to be Inserted on the table
	var data = {
	"username": $root/MainWindow/LoginWindow/wndRegister/RegUsernameBox.text,
	"password": $root/MainWindow/LoginWindow/wndRegister/RegUsernameBox.text,
	"type": 2
	}
#Inserir os dados na tabela
	database.insert_row("Accounts", data)

#Type Selector Logic
func _on_type_selector_item_selected(index) -> void:
#If your adding a user hide the email box
	if index == 2:
		$MarginContainer/Content/DownloadPanel/Control/UniEmailBox.hide()
	else:
		$MarginContainer/Content/DownloadPanel/Control/UniEmailBox.show()

#Deletion Button Logic
func _on_deletion_button_button_down() -> void:
	var id: int
	#Get the name of the selected item and convert to an int
	id = int($MarginContainer/Content/DownloadPanel/Control/AccountSelector.get_item_text($MarginContainer/Content/DownloadPanel/Control/AccountSelector.selected))
	#There probably is a better way to do this but who cares
	#Delete the row with the same id as the selected id
	database.delete_rows("Accounts", "id = %s" % [id])


func _on_add_account_button_button_down():
	pass # Replace with function body.
