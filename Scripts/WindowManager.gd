extends Control
#TODO: When package system is made block TempUsers from getting them or whatever felipe wants
#Priviledge Sintax: 0 = Admin, 1 = Artist, 2 = User, 3 = TempUser
var priviledge: int 
var text: Array
var login: String
var password: String

func _ready() -> void:
#  WARNING Hides Everything else so only the LoginWindow Appears
	#$Windows.hide()
	#$Header.hide()
	# Get all the Accounts from the database
	text = $Windows/wndAdmin._read_table("type")
	#Set All Accounts as Options on the AccountSelector
	for i in text.size():
		%AccountSelector.add_item(str(text[i]['id']), i)


func getControl(node:Control) -> Array:
		var children:Array = []
		for i in node.get_children():
			children.append(i)
		return children

#TODO: REFACTOR
func _on_btn_projetos_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[0].visible = true
	
	for i in nodes.size():
		if i != 0:
			nodes[i].visible = false
			
func _on_btn_install_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[1].visible = true
	
	for i in nodes.size():
		if i != 1:
			nodes[i].visible = false

func _on_btn_pacotes_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[2].visible = true
	
	for i in nodes.size():
		if i != 2:
			nodes[i].visible = false


func _on_btn_conta_button_down() -> void:
	var nodes:Array = getControl($Windows)
	nodes[3].visible = true
	
	for i in nodes.size():
		if i != 3:
			nodes[i].visible = false


func _on_btn_sair_button_down() -> void:
	get_tree().quit()


func _on_btn_admin_button_down() -> void:
	#Check if Login is admin so he can open this page
	if priviledge == 0:
		var nodes:Array = getControl($Windows)
		nodes[4].visible = true
		
		for i in nodes.size():
			if i != 4:
				nodes[i].visible = false

func _on_login_button_button_down() -> void:
	#Get Input from the user
		login = $LoginWindow/wndMain/UsernameBox.text
		password = $LoginWindow/wndMain/PasswordBox.text  
		#Loop throught all the logins
		for i in text.size():
			#Check if email or username is correct
			if login == text[i]['email'] || login == text[i]['username']:
				#Check if login isnt equal to nothing
				if login != "":
					#Check if password is correct
					if password == text[i]['password']:
						#Hide login and turn everything back on
						$LoginWindow.hide()
						$Windows.show()
						$Header.show()
						#Set priviledge as the one from the account
						priviledge = text[i]['type']
						#Set Current Username to Account Page
						$Windows/wndConta/MarginContainer/Content/PainelConta/TextEditnome.text = text[i]['username']
						$Windows/wndConta/MarginContainer/Content/NameLabel.text = text[i]['username']
						#Set Current Email to Account Page
						$Windows/wndConta/MarginContainer/Content/PainelConta/TextEditemail.text = text[i]['email']
						#Set Current Priviledge to Account Page
						var Type: String = "Sem Permissões"
						if priviledge == 0:
							Type = "Admin"
						if priviledge == 1:
							Type = "Artista"
						%TypeLabel.text = "Tipo de Conta: " + Type
			else:
			#Wrong Login
				print("Incorrect.")


#Cancel Button wndMain
func _on_cancel_button_button_down() -> void:
	get_tree().quit()

#Login as a Temporary User
func _on_user_button_button_down() -> void:
	priviledge = 3
	$LoginWindow.hide()
	$Windows.show()
	$Header.show()
