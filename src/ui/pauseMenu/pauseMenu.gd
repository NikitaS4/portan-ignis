extends CanvasLayer
var keyboard = false
var game_paused = false
export (bool) var hide_at_start = true
var pos = -1

func _ready():
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Continue/ContLight.range_layer_min=1
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Continue/ContLight.range_layer_max=1
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Settings/SetLight.range_layer_min=1
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Settings/SetLight.range_layer_max=1
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/MainMenu/MenuLight.range_layer_min=1
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/MainMenu/MenuLight.range_layer_max=1
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.range_layer_min=1
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.range_layer_max=1
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/Label/CheckBox/CheckLight.range_layer_min=1
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/Label/CheckBox/CheckLight.range_layer_max=1
	if hide_at_start:
		$PauseMenu.hide()
	if OS.window_fullscreen:
		$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/Label/CheckBox.pressed = true
		_full_screen()

func _input(event):
	if event is InputEventMouseMotion:
		if(keyboard) :
			_closeBeforeChange()
			keyboard=false
			pos=-1

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if($PauseMenu/CenterContainer/CenterContainer/Pause.is_visible_in_tree()||!game_paused):
			game_paused = !game_paused
			process_pause()
			_closeBeforeChange()
		if($PauseMenu/CenterContainer/CenterContainer/Settings.is_visible_in_tree()):
			_closeBeforeChange()
			_on_backSettings_pressed()
		pos=-1
	if Input.is_action_just_pressed("ui_down"):
		_closeBeforeChange()
		pos+=1
		keyboard=true
		_changePos()
	if Input.is_action_just_pressed("ui_up"):
		_closeBeforeChange()
		pos-=1
		keyboard=true
		_changePos()
	if Input.is_action_just_pressed("ui_accept"):
		_closeBeforeChange()
		_pressButt()
		pos=-1

func _pressButt():
	if($PauseMenu/CenterContainer/CenterContainer/Pause.is_visible_in_tree()):
		if(pos==0):
			_on_Continue_pressed()
			return
		if(pos==1):
			_on_Settings_pressed()
			return
		if (pos==2):
			_on_MainMenu_pressed()
			return
	if($PauseMenu/CenterContainer/CenterContainer/Settings.is_visible_in_tree() && $PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.is_visible_in_tree()):
		_on_backSettings_pressed()
		return

func _changePos():
	if(pos<0):pos=0
	if($PauseMenu/CenterContainer/CenterContainer/Pause.is_visible_in_tree()):
		if(pos==0):
			_on_Continue_mouse_entered()
			return
		if(pos==1):
			_on_Settings_mouse_entered()
			return
		if (pos>=2):
			_on_MainMenu_mouse_entered()
			return
	if($PauseMenu/CenterContainer/CenterContainer/Settings.is_visible_in_tree()):
		_on_backSettings_mouse_entered()
		return

func _closeBeforeChange():
	if($PauseMenu/CenterContainer/CenterContainer/Pause.is_visible_in_tree()):
		if(pos==0):
			_on_Continue_mouse_exited()
			return
		if(pos==1):
			_on_Settings_mouse_exited()
			return
		if (pos==2):
			_on_MainMenu_mouse_exited()
			return
	if($PauseMenu/CenterContainer/CenterContainer/Settings.is_visible_in_tree()):
		_on_backSettings_mouse_exited()
		return



func process_pause():
	if game_paused:
		get_tree().paused = true
		$PauseMenu.show()
	else:
		get_tree().paused = false
		reset_menu();
		$PauseMenu.hide()

func reset_menu():
	$PauseMenu/CenterContainer/CenterContainer/Settings.hide()
	$PauseMenu/CenterContainer/CenterContainer/Pause.show()


func _on_backSettings_pressed():
	pos=-1
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.disable()
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.hide()
	$PauseMenu/CenterContainer/CenterContainer/Settings.hide()
	$PauseMenu/CenterContainer/CenterContainer/Pause.show()

func _full_screen():
	if OS.window_fullscreen:
		$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/Label/CheckBox/CheckLight.enable()
		$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/Label/CheckBox/CheckLight.show()
	else:
		$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/Label/CheckBox/CheckLight.disable()


func _on_CheckBox_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	_full_screen()


func _on_Continue_pressed():
	pos=-1
	game_paused = false
	process_pause()


func _on_Settings_pressed():
	pos=-1
	$PauseMenu/CenterContainer/CenterContainer/Pause.hide()
	$PauseMenu/CenterContainer/CenterContainer/Settings.show()
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Settings/SetLight.hide()
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Settings/SetLight.disable()


func _on_MainMenu_pressed():
	pos=-1
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/MainMenu/MenuLight.hide()
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/MainMenu/MenuLight.disable()
	game_paused = false
	process_pause()
	SceneSwitcher.goto_scene(SceneSwitcher.Scenes.SCENE_MAIN_MENU)


func _on_Continue_mouse_entered():
	pos=0
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Continue/ContLight.show()
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Continue/ContLight.enable()


func _on_Continue_mouse_exited():
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Continue/ContLight.disable()


func _on_Settings_mouse_entered():
	pos=1
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Settings/SetLight.show()
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Settings/SetLight.enable()


func _on_MainMenu_mouse_entered():
	pos=2
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/MainMenu/MenuLight.show()
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/MainMenu/MenuLight.enable()


func _on_MainMenu_mouse_exited():
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/MainMenu/MenuLight.disable()


func _on_Settings_mouse_exited():
	$PauseMenu/CenterContainer/CenterContainer/Pause/Sprite/Settings/SetLight.disable()


func _on_backSettings_mouse_entered():
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.enable()
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.show()


func _on_backSettings_mouse_exited():
	$PauseMenu/CenterContainer/CenterContainer/Settings/Sprite/backSettings/backLight.disable()
