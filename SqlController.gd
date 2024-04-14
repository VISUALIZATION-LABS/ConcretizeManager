extends Control
@onready var table_current: String
var database: SQLite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#Inciciação da Tabela e path da tabela
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
	_read_table("Admins")

func _read_table(table) -> Array:
	return database.select_rows(table, "", ["*"])

func _on_tab_container_tab_changed(tab) -> void:
	var text: Array
	%OutAdmins.set_text("")
	%OutArtists.set_text("")
	%OutUser.set_text("")
	match tab:
		0:
			text = _read_table("Admins")
			for i in text.size():
				print(text[i])
				%OutAdmins.text += "Id: " + str(text[i]['id']) + "\n"
				%OutAdmins.text += "Email: " + text[i]['email'] + "\n"
				%OutAdmins.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutAdmins.text += "Senha: " + str(text[i]['password']) + "\n"

		1:
			text = _read_table("Artist")
			for i in text.size():
				print(text[i])
				%OutArtists.text += "Id: " + str(text[i]['id']) + "\n"
				%OutArtists.text += "Email: " + text[i]['email'] + "\n"
				%OutArtists.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutArtists.text += "Senha: " + str(text[i]['password']) + "\n"

		2:
			text = _read_table("User")
			for i in text.size():
				print(text[i])
				%OutUser.text += "Id: " + str(text[i]['id']) + "\n"
				%OutUser.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutUser.text += "Senha: " + str(text[i]['password']) + "\n"

