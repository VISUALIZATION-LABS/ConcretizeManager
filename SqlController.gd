extends Control

var text: Array
var database: SQLite

func _ready() -> void:
#Inciciação da Tabela e path da tabela
	database = SQLite.new()
	database.path="res://data.db"
	database.open_db()
#Inserir dados da tabela quando a pagina admin é inciada pela primeira vez
	text = _read_table("Admins")
	for i in text.size():
		print(text[i])
		%OutAdmins.text += "Id: " + str(text[i]['id']) + "\n"
		%OutAdmins.text += "Email: " + text[i]['email'] + "\n"
		%OutAdmins.text += "Nome de Usuario: " + text[i]['username'] + "\n"
		%OutAdmins.text += "Senha: " + str(text[i]['password']) + "\n"

#Obter dados da tabela e retorna-los sintaxe: "table name", "conditions", "what to get"
func _read_table(table) -> Array:
	return database.select_rows(table, "", ["*"])


#Funcionalidade das Abas
func _on_tab_container_tab_changed(tab) -> void:
#Limpar as Caixas de Texto todas as vezes que se mudar de aba
	%OutAdmins.set_text("")
	%OutArtists.set_text("")
	%OutUser.set_text("")
#Descobrir qual tabela é Sintaxe: 0 = Admins, 1 = Artistas, 2 = Usuarios
	match tab:
		0:
			#Passar por todos os itens da tabela e Inserir-los na Caixa OutAdmins
			#Sintaxe: variavel com dados da tabela [Posição dos Dados][Dados a Ser Utilizado]
			for i in text.size():
				print(text[i])
				%OutAdmins.text += "Id: " + str(text[i]['id']) + "\n"
				%OutAdmins.text += "Email: " + text[i]['email'] + "\n"
				%OutAdmins.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutAdmins.text += "Senha: " + str(text[i]['password']) + "\n"

		1:
			#Receber dados da tabela em array
			text = _read_table("Artist")
			#Passar por todos os itens da tabela e Inserir-los na Caixa OutArtists
			#Sintaxe: variavel com dados da tabela [Posição dos Dados][Dados a Ser Utilizado]
			for i in text.size():
				print(text[i])
				%OutArtists.text += "Id: " + str(text[i]['id']) + "\n"
				%OutArtists.text += "Email: " + text[i]['email'] + "\n"
				%OutArtists.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutArtists.text += "Senha: " + str(text[i]['password']) + "\n"

		2:
			#Receber dados da tabela em array
			text = _read_table("User")
			#Passar por todos os itens da tabela e Inserir-los na Caixa OutUser
			#Sintaxe: variavel com dados da tabela [Posição dos Dados][Dados a Ser Utilizado]
			for i in text.size():
				print(text[i])
				%OutUser.text += "Id: " + str(text[i]['id']) + "\n"
				%OutUser.text += "Nome de Usuario: " + text[i]['username'] + "\n"
				%OutUser.text += "Senha: " + str(text[i]['password']) + "\n"

