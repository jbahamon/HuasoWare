extends MarginContainer

func _ready():
	$VBoxContainer/MenuOptions/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://scenes/GameContainer.tscn")


func _on_Exit_pressed():
	get_tree().quit()
