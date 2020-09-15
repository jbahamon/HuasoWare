extends CanvasLayer

func show_message(text):
	$GameStatus.text = text
	$AnimationPlayer.play("pop")

func _on_win():
	show_message("UYUUUUI!!")


func _on_lose():
	show_message("JUEEEE...")

