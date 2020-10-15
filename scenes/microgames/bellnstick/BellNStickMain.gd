extends "res://scenes/microgames/Microgame.gd"

export (PackedScene) var WinBell

func _ready():
	randomize()

func _on_Stick_hit():
	game_won = true
	emit_signal("win")
	var bell = WinBell.instance()
	add_child(bell)
	bell.position = $Stick.position - Vector2(0, 100)
	$GeneralAnimation.play("scroll_back")


func _on_GameOverArea_body_entered(_body):
	game_won = false
	emit_signal("lose")


func _on_HUD_message_over():
	emit_signal("game_over", game_won)
