extends "res://scenes/microgames/Microgame.gd"

export (PackedScene) var WinBell

signal win
signal lose

func _ready():
	randomize()

func _on_Stick_hit():
	var bell = WinBell.instance()
	add_child(bell)
	bell.position = $Stick.position - Vector2(0, 100)
	$GeneralAnimation.play("scroll_back")
	
	game_won = true
	$Stick.disable()
	$WinBG.visible = true
	$WinSound.play()
	emit_signal("win")


func _on_GameOverArea_body_entered(_body):
	game_won = false
	$Stick.disable()
	$BGMusic.stop()
	$LoseSound.play()
	emit_signal("lose")


func _on_HUD_message_over():
	emit_signal("game_over", game_won)


func _on_animation_finished(anim_name):
	if anim_name == 'swing':
		$Stick.enable()
