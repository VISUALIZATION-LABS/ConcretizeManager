extends Control

var priviledge: int
var text: Array
var login: String
var password: String

func _ready() -> void:
# Hides Everything else so only the LoginWindow Appears
	$Windows.hide()
	$Header.hide()
	# Get all the Accounts from the database
	text = $Windows/wndAdmin._read_table("type")


func getControl(node:Control) -> Array:
		var children:Array = []
		for i in node.get_children():
			children.append(i)
		return children

#TODO: REFACTOR

func _on_btn_install_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[0].visible = true
	
	for i in nodes.size():
		if i != 0:
			nodes[i].visible = false

func _on_btn_pacotes_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[1].visible = true
	
	for i in nodes.size():
		if i != 1:
			nodes[i].visible = false


func _on_btn_conta_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[2].visible = true
	
	for i in nodes.size():
		if i != 2:
			nodes[i].visible = false


func _on_btn_sair_button_down() -> void:
	get_tree().quit()


func _on_btn_admin_button_down() -> void:
	#Check if Account has priviledge to open this page
	if priviledge == 0:
		var nodes:Array = getControl($Windows)
		nodes[3].visible = true
		
		for i in nodes.size():
			if i != 3:
				nodes[i].visible = false

func _on_login_button_button_down():
	#Get Input from the user
		login = $LoginWindow/UsernameBox.text
		password = $LoginWindow/PasswordBox.text  
		#Loop throught all the logins
		for i in text.size():
			#If login as email or username is correct
			if login == text[i]['email'] || login == text[i]['username']:
				#Password Check
				if password == text[i]['password']:
					#Hide login and turn everything back on
					$LoginWindow.hide()
					$Windows.show()
					$Header.show()
					#Set priviledge as the one from the account
					priviledge = text[i]['type']
			else:
			#Wrong Login
				print("Incorrect.")
