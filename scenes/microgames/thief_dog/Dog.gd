extends Node2D
signal try_chomp
signal try_chomp_finish


func _ready():
	$Path2D/PathFollow2D.progress_ratio = 0.5
	
func on_try_chomp():
	$Path2D/PathFollow2D.progress_ratio = 0.5
	$AnimationPlayer.play("try_chomp")
	emit_signal("try_chomp")

func on_win():
	$AnimationPlayer.play("chomp")
	$ChompSound.play()
	
	
func on_lose():
	$AnimationPlayer.play("caught")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		set_process_input(false)
		on_try_chomp()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "try_chomp":
		emit_signal("try_chomp_finish")
		
func freeze():
	set_process(false)
	set_process_input(false)
	$AnimationPlayer.stop()
