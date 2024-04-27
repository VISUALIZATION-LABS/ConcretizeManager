extends Control

var output_text: Array
var database: SQLite
func _ready() -> void:
#Inciciação da Tabela e path da tabela
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
#Dados da Tablela = id, email, username, password, type
#Inserir dados da tabela quando a pagina admin é inciada pela primeira vez
	output_text = _read_table(0)
	for i in output_text.size():
		print(output_text[i])
		%OutAdmins.text += "Id: " + str(output_text[i]['id']) + "\n"
		%OutAdmins.text += "Email: " + output_text[i]['email'] + "\n"
		%OutAdmins.text += "Nome de Usuario: " + output_text[i]['username'] + "\n"
		%OutAdmins.text += "Senha: " + str(output_text[i]['password']) + "\n"
	#Add Options For TypeSelector
	$MarginContainer/Content/DownloadPanel/Control/TypeSelector.add_item("Admin", 0)
	$MarginContainer/Content/DownloadPanel/Control/TypeSelector.add_item("Artist", 1)
	$MarginContainer/Content/DownloadPanel/Control/TypeSelector.add_item("User", 2)

#Obter dados da tabela e retorna-los sintaxe: "table name", "conditions", "what to get"
#Using workaround to insert value inside string
func _read_table(type) -> Array:
	return database.select_rows("Accounts", "type = %s" % [type], ["*"])

#Refresh options from account select
#Obs: First declarition of options in WindowManager.gd
func _update_account_select() -> void:
	#Remove all of the old options
	$MarginContainer/Content/DownloadPanel/Control/AccountSelector.clear()
	# Get all the Ids from the database
	output_text = database.select_rows("Accounts", "", ["id"])
	#Set All Ids as Options on the AccountSelector
	for i in output_text.size():
		$MarginContainer/Content/DownloadPanel/Control/AccountSelector.add_item(str(output_text[i]['id']), i)
	#Refresh Current Tab
	_on_tab_container_tab_changed($MarginContainer/Content/DownloadPanel/Control/TabContainer.current_tab)

#Funcionalidade das Abas
func _on_tab_container_tab_changed(tab) -> void:
#Limpar as Caixas de Texto todas as vezes que se mudar de aba
	%OutAdmins.set_text("")
	%OutArtists.set_text("")
	%OutUser.set_text("")
#Descobrir qual tabela é Sintaxe: 0 = Admins, 1 = Artistas, 2 = Usuarios
	output_text = _read_table(tab)
#Utilizar dados do correspondente tipo de acordo com a sintaxe
	match tab:
		0:
			for i in output_text.size():
				print(output_text[i])
				%OutAdmins.text += "Id: " + str(output_text[i]['id']) + "\n"
				%OutAdmins.text += "Email: " + output_text[i]['email'] + "\n"
				%OutAdmins.text += "Nome de Usuario: " + output_text[i]['username'] + "\n"
				%OutAdmins.text += "Senha: " + str(output_text[i]['password']) + "\n"
		1:
			for i in output_text.size():
				print(output_text[i])
				%OutArtists.text += "Id: " + str(output_text[i]['id']) + "\n"
				%OutArtists.text += "Email: " + output_text[i]['email'] + "\n"
				%OutArtists.text += "Nome de Usuario: " + output_text[i]['username'] + "\n"
				%OutArtists.text += "Senha: " + str(output_text[i]['password']) + "\n"
		2:
			for i in output_text.size():
				print(output_text[i])
				%OutUser.text += "Id: " + str(output_text[i]['id']) + "\n"
				%OutUser.text += "Email: " + output_text[i]['email'] + "\n"
				%OutUser.text += "Nome de Usuario: " + output_text[i]['username'] + "\n"
				%OutUser.text += "Senha: " + str(output_text[i]['password']) + "\n"

#Registers a user from the register screen
func _on_register_button_button_down() -> void:
#Data to be Inserted on the table
	var data = {
	"email": "",
	"username": $/root/MainWindow/LoginWindow/wndRegister/RegUsernameBox.text,
	"password": $/root/MainWindow/LoginWindow/wndRegister/RegPasswordBox.text,
	"type": 2
	}
#Inserir os dados na tabela
	database.insert_row("Accounts", data)

#Detect if the account your creating is a user if so delete email box
func _on_type_selector_item_selected(index) -> void:
#If your adding a user hide the email box
	if index == 2:
		$MarginContainer/Content/DownloadPanel/Control/UniEmailBox.hide()
	else:
		$MarginContainer/Content/DownloadPanel/Control/UniEmailBox.show()

#Delete account according to the Id Selected
func _on_deletion_button_button_down() -> void:
	var id: int
	#Get the name of the selected item and convert to an int
	id = int($MarginContainer/Content/DownloadPanel/Control/AccountSelector.get_item_text($MarginContainer/Content/DownloadPanel/Control/AccountSelector.selected))
	#There probably is a better way to do this but who cares
	#Delete the row with the same id as the selected id
	database.delete_rows("Accounts", "id = %s" % [id])
	#Refresh Ids on Account Select
	_update_account_select()

#Add new account with data input
func _on_add_account_button_button_down():
	var info: Dictionary = {
	"username" = $MarginContainer/Content/DownloadPanel/Control/UniUserBox.text,
	"password" = $MarginContainer/Content/DownloadPanel/Control/UniPassBox.text,
	"type" = $MarginContainer/Content/DownloadPanel/Control/TypeSelector.selected
	}
	if $MarginContainer/Content/DownloadPanel/Control/TypeSelector.selected != 2:
		info["email"] = $MarginContainer/Content/DownloadPanel/Control/UniEmailBox.text
	else:
		info["email"] = ""
	database.insert_row("Accounts", info)
	#Refresh Ids on Account Select
	_update_account_select()
