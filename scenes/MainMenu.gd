extends MarginContainer

func _ready():
	$VBoxContainer/MenuOptions/Start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene_to_file("res://scenes/GameContainer.tscn")

func _on_Credits_pressed():
	get_tree().change_scene_to_file("res://scenes/Credits.tscn")

func _on_Exit_pressed():
	get_tree().quit()
