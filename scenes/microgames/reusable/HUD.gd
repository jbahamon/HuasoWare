extends CanvasLayer


func show_message(text):
	$GameStatus.text = text
	$AnimationPlayer.play("pop")


func _on_win():
	show_message("UYUUUUI!!")


func _on_lose():
	show_message("JUEEEE...")


func set_timer_enabled(val):
	$Timer.visible = val


func update_timer(remaining_time):
	$Timer.text = "%.3f" % remaining_time
