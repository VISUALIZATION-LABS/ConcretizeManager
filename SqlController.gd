extends Control

var table_text: Array
var database: SQLite

func _ready() -> void:
#Inciciação da Tabela e path da tabela
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
#Dados da Tablela = id, email, username, password, type
#Inserir dados da tabela quando a pagina admin é inciada pela primeira vez
	table_text = _read_table(0)
	_output_table($MarginContainer/Content/DownloadPanel/Control/TabContainer/Admins/OutAdmins)
	#Add Options For TypeSelector
	%TypeSelector.add_item("Admin", 0)
	%TypeSelector.add_item("Artist", 1)
	%TypeSelector.add_item("User", 2)

#Obter dados da tabela e retorna-los sintaxe: "table name", "conditions", "what to get"
#Using workaround to insert value inside string
func _read_table(type) -> Array:
	return database.select_rows("Accounts", "type = %s" % [type], ["*"])

#Write data from table to the text boxes
#We suppose we already have the table_text saved to the variable
func _output_table(output) -> void:
	for i in table_text.size():
		output.text += "Id: " + str(table_text[i]['id']) + "\n"
		output.text += "Email: " + table_text[i]['email'] + "\n"
		output.text += "Nome de Usuario: " + table_text[i]['username'] + "\n"
		output.text += "Senha: " + table_text[i]['password'] + "\n"
		
#Refresh options from account select
#Obs: First declarition of options in WindowManager.gd
func _update_account_select() -> void:
	#Remove all of the old options
	%AccountSelector.clear()
	# Get all the Ids from the database
	table_text = database.select_rows("Accounts", "", ["id"])
	#Set All Ids as Options on the AccountSelector
	for i in table_text.size():
		%AccountSelector.add_item(str(table_text[i]['id']), i)


#Funcionalidade das Abas
func _on_tab_container_tab_changed(tab) -> void:
#Limpar as Caixas de Texto todas as vezes que se mudar de aba
	$MarginContainer/Content/DownloadPanel/Control/TabContainer/Admins/OutAdmins.set_text("")
	$MarginContainer/Content/DownloadPanel/Control/TabContainer/Artists/OutArtists.set_text("")
	$MarginContainer/Content/DownloadPanel/Control/TabContainer/Users/OutUser.set_text("")
#Read the table according to the tab
	table_text = _read_table(tab)
#Output the text to the corresponding tab
	match tab:
		0:
			_output_table($MarginContainer/Content/DownloadPanel/Control/TabContainer/Admins/OutAdmins)
		1:
			_output_table($MarginContainer/Content/DownloadPanel/Control/TabContainer/Artists/OutArtists)
		2:
			_output_table($MarginContainer/Content/DownloadPanel/Control/TabContainer/Users/OutUser)

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
#Display login screen again
	$/root/MainWindow/LoginWindow/wndRegister.hide()
	$/root/MainWindow/LoginWindow/wndMain.show()

#Detect if the account your creating is a user if so delete email box
func _on_type_selector_item_selected(index) -> void:
#If your adding a user hide the email box
	if index == 2:
		$MarginContainer/Content/DownloadPanel/Control/UniEmailBox.hide()
	else:
		$MarginContainer/Content/DownloadPanel/Control/UniEmailBox.show()

#Delete account according to the Id Selected
func _on_deletion_button_button_down() -> void:
	var id: String
	#Get the name of the selected item and convert to an int
	id = %AccountSelector.get_item_text(%AccountSelector.selected)
	#There probably is a better way to do this but who cares
	#Delete the row with the same id as the selected id
	database.delete_rows("Accounts", "id = %s" % [id])
	#Refresh Ids on Account Select
	_update_account_select()
	#Refresh Current Tab
	_on_tab_container_tab_changed($MarginContainer/Content/DownloadPanel/Control/TabContainer.current_tab)

#Add new account with data input
func _on_add_account_button_button_down():
	var info: Dictionary = {
	"username" = $MarginContainer/Content/DownloadPanel/Control/UniUserBox.text,
	"password" = $MarginContainer/Content/DownloadPanel/Control/UniPassBox.text,
	"type" = %TypeSelector.selected
	}
	if %TypeSelector.selected != 2:
		info["email"] = $MarginContainer/Content/DownloadPanel/Control/UniEmailBox.text
	else:
		info["email"] = ""
	database.insert_row("Accounts", info)
	#Refresh Ids on Account Select
	_update_account_select()
	#Refresh Current Tab
	_on_tab_container_tab_changed($MarginContainer/Content/DownloadPanel/Control/TabContainer.current_tab)
