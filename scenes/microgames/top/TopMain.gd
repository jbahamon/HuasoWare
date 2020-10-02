extends Node

signal trompo_win
signal trompo_lose


func _ready():
	randomize()
	$HUD.set_timer_enabled(true)


func _process(_delta):
	$HUD.update_timer($WinTimer.time_left)


func _on_SpinningTop_fell():
	$WinTimer.stop()
	$HUD.set_timer_enabled(false)
	emit_signal("trompo_lose")


func _on_WinTimer_timeout():
	emit_signal("trompo_win")
