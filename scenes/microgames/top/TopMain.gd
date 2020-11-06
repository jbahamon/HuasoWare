extends "res://scenes/microgames/Microgame.gd"

signal trompo_win
signal trompo_lose

enum ArrowState { LEFT, RIGHT, NONE }

var current_arrow_state = ArrowState.NONE

func _ready():
	randomize()
	$HUD.set_timer_enabled(true)
	update_arrows(ArrowState.NONE)

func _process(_delta):
	$HUD.update_timer($WinTimer.time_left)
	
	if $SpinningTop.rotation > 0 and current_arrow_state != ArrowState.LEFT:
		update_arrows(ArrowState.LEFT)
	elif $SpinningTop.rotation < 0 and current_arrow_state != ArrowState.RIGHT:
		update_arrows(ArrowState.RIGHT)
	elif $SpinningTop.rotation == 0 and current_arrow_state != ArrowState.NONE:
		update_arrows(ArrowState.NONE)

func _on_SpinningTop_fell():
	$WinTimer.stop()
	game_won = false
	$HUD.set_timer_enabled(false)
	update_arrows(ArrowState.NONE)
	set_process(false)
	emit_signal("trompo_lose")


func _on_WinTimer_timeout():
	game_won = true
	set_process(false)
	update_arrows(ArrowState.NONE)
	emit_signal("trompo_win")


func _on_HUD_message_over():
	emit_signal("game_over", game_won)

func update_arrows(arrow_state):
	match arrow_state:
		ArrowState.LEFT:
			current_arrow_state = ArrowState.LEFT
			$Arrows/Left.modulate = Color(1, 1, 1, 1)
			$Arrows/Right.modulate = Color(1, 1, 1, 0)
		ArrowState.RIGHT:
			current_arrow_state = ArrowState.RIGHT
			$Arrows/Left.modulate = Color(1, 1, 1, 0)
			$Arrows/Right.modulate = Color(1, 1, 1, 1)
		ArrowState.NONE:
			current_arrow_state = ArrowState.NONE
			$Arrows/Left.modulate = Color(1, 1, 1, 0)
			$Arrows/Right.modulate = Color(1, 1, 1, 0)
