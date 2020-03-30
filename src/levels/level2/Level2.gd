extends Node2D

signal falls
signal win

func _ready():
	$IgnisRegularOuter.connect("ignis_regular_taken", $Player, "_on_IgnisRegularOuter_ignis_regular_taken")
	$Player.prepare_camera($Level2Landscape.posLU, $Level2Landscape.posRD)
	connect("falls", self, "_on_Player_die")
	$Player.connect("die", self, "_on_Player_die")
	
	$Ignises/IgnisDoor.connect("active", $Level2Landscape/Doors/Door2, "_on_IgnisRegularLevel_active")
	$Ignises/IgnisDoor.connect("not_active", $Level2Landscape/Doors/Door2, "_on_IgnisRegularLevel_not_active")
	$Ignises/IgnisDoor.activate_at_start()
	$Ignises/IgnisActivated.activate_at_start()
	
	$WinWindow/MarginContainer.hide()
	$HUD/HUD.init_player($Player)
	$WindowGameOver/MarginContainer.hide()
	
	
func _on_Player_die():
	get_tree().paused = true
	$WindowGameOver._closeBefore()
	$WindowGameOver/MarginContainer.show()


func _on_Death_body_entered(body):
	if body.has_method("get_informator"):
		emit_signal("falls")
	elif body.has_method("check_chase"):
		$Enemy.queue_free()


func _on_Win_body_entered(body):
	if body.has_method("get_informator"):
		$WinWindow/MarginContainer.show()
		get_tree().paused = true
