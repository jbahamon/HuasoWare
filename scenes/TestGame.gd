extends "res://scenes/microgames/Microgame.gd"

signal win
signal lose
	
func _input(event):
	
	var win_pressed = event.is_action_pressed("ui_accept")
	var lose_pressed = event.is_action_pressed("ui_cancel")
	
	if win_pressed and not lose_pressed:
		game_won = true
		set_process_input(false)
		emit_signal("win")
	
	
	if not win_pressed and lose_pressed:
		game_won = false
		set_process_input(false)
		emit_signal("lose")


func _on_HUD_message_over():
	emit_signal("game_over", game_won)
