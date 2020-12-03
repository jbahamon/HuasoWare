extends Node

var idle_time = 3.0
var doubt_time = 1.0
var look_time = 2.0

signal win
signal lose

func _ready():
	$HUD.set_timer_enabled(true)
	$DogCloseUp.position = $Dog.position

func _process(delta):
	$HUD.update_timer($LoseTimer.time_left)


func _on_Dog_try_chomp():
	$LoseTimer.stop()
	$HUD.set_timer_enabled(false)
	$LadyAndBG.set_process(false)
	$Dog.did_win = not $LadyAndBG.is_looking()
	$DogCloseUp.current = true
	
	
func  _on_Dog_try_chomp_finish(did_win):
	if did_win:
		$AnimationPlayer.play("win")
		$Dog.on_win()
	else:
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
	$HUD.update_timer(0)
	$HUD._on_lose()

