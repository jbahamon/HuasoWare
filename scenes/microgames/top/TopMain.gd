extends "res://scenes/microgames/Microgame.gd"

signal trompo_win
signal trompo_lose

func _ready():
	randomize()
	$HUD.set_timer_enabled(true)


func _process(_delta):
	$HUD.update_timer($WinTimer.time_left)


func _on_SpinningTop_fell():
	$WinTimer.stop()
	game_won = false
	$HUD.set_timer_enabled(false)
	emit_signal("trompo_lose")


func _on_WinTimer_timeout():
	game_won = true
	emit_signal("trompo_win")

func _on_HUD_message_over():
	emit_signal("game_over", game_won)
