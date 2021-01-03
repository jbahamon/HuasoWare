extends Node

var idle_time = 3.0
var doubt_time = 1.0
var look_time = 2.0
var game_won

signal game_over


func _ready():
	$DogCloseUp.position = $Dog.position


func _process(_delta):
	$HUD.update_timer($LoseTimer.time_left)


func _on_Dog_try_chomp():
	game_won = not $LadyAndBG.is_looking()
	$LoseTimer.stop()
	$HUD.set_timer_enabled(false)
	$LadyAndBG.freeze()
	$ZoomSound.play()
	$DogCloseUp/BG.enable_beams()
	$DogCloseUp.current = true
	
	
func  _on_Dog_try_chomp_finish():
	$BGMusic.stop()
	if game_won:
		$AnimationPlayer.play("win")
		$Dog.on_win()
		$WinSound.play()
		$DogCloseUp/BG.enable_shines()
	else:
		$DogCloseUp/BG.disable()
		$AnimationPlayer.play("lose")
		$LadyAndBG.on_catch_dog()
		$LadyCloseUp.shake(2, 120, 20)
		$Dog.on_lose()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "win":
		$HUD._on_win()
	elif anim_name == "lose":
		$HUD._on_lose()


func _on_LoseTimer_timeout():
	game_won = false
	$LadyAndBG.freeze()
	$Dog.freeze()
	$BGMusic.stop()
	$HUD.update_timer(0)
	$HUD._on_lose()


func _on_HUD_message_over():
	emit_signal("game_over", game_won)
