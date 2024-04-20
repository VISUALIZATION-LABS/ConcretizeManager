extends Control

@export var priviledge: int
var text: Array
var login: String
var password: String

func _ready():
# Get all the Accounts from the database
	text = %wndAdmin._read_table("type")

func _on_login_button_button_down():
	login = $UsernameBox.text
	password = $PasswordBox.text  
	for i in text.size():
		if login == text[i]['email'] || login == text[i]['username']:
			if password == text[i]['password']:
				$/root/MainWindow/LoginWindow.hide()
				$/root/MainWindow/Windows.show()
				$/root/MainWindow/Header.show()
		else:
			print("Incorrect.")
