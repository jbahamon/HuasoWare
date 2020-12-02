extends CanvasLayer
signal message_over

func show_message(text):
	$GameStatus.text = text
	$AnimationPlayer.play("pop")


func _on_win():
	show_message("UYUUUUI!!")
	$WinSound.play()


func _on_lose():
	show_message("JUEEEE...")
	$LoseSound.play()


func set_timer_enabled(val):
	$Timer.visible = val


func update_timer(remaining_time):
	$Timer.text = "%.2f" % remaining_time


func _on_animation_finished(_anim_name):
	emit_signal("message_over")
