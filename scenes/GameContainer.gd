extends Node

var games = [
	load("res://scenes/microgames/bellnstick/BellNStickMain.tscn"),
	load("res://scenes/microgames/top/TopMain.tscn"),
	load("res://scenes/microgames/kite/KiteMain.tscn"),
	load("res://scenes/microgames/thiefdog/ThiefDog.tscn"),
]

var score = 0
var lives = 4
var current_game = null

onready var score_label = $TransitionUI/VBoxContainer/Score
onready var lives_label = $TransitionUI/VBoxContainer/Lives
onready var next_game_label = $TransitionUI/VBoxContainer/ReferenceRect/ColorRect/NextGameLabel

func _ready():
	update_labels()
	$NextGameTimer.start()

func _process(_delta):
	next_game_label.text = "Next game in\n%d" % (floor($NextGameTimer.time_left) + 1)

func _on_next_game():
	$AnimationPlayer.current_animation = "ui_out"
	$AnimationPlayer.play()
	
func _on_transition_finished(animation_name):
	match animation_name:
		"ui_out":
			$TransitionUI.visible = false
			$Camera2D.zoom = Vector2(1, 1)
			$BGSong.stop()
			instance_game()
		"game_in":
			start_game()
		"game_out":
			$Background.modulate = Color.from_hsv(randf(), 0.25, 1.0)
			remove_child(current_game)
			
			current_game = null
			$AnimationPlayer.current_animation = "ui_in"
			$AnimationPlayer.play()
			$TransitionUI.visible = true
			$Camera2D.zoom = Vector2(0.1, 0.1)
		"ui_in":
			update_labels()
			if lives > 0:
				$BGSong.play()
				$NextGameTimer.start()
				next_game_label.set("custom_colors/font_color", Color(1,1,1))
			else:
				$CanvasLayer/GameOverUI/GameOverLabel.text = "GAME OVER\nFINAL SCORE: %d" % score
				$AnimationPlayer.current_animation = "game_over"
				$AnimationPlayer.play()
		"game_over":
			$CanvasLayer/GameOverUI/HBoxContainer/TryAgainButton.grab_focus()

func instance_game():
	current_game = games[randi() % games.size()].instance()
	add_child(current_game)
	
	current_game.set_process(false)
	current_game.set_physics_process(false)
	current_game.set_process_input(false)
	
	$AnimationPlayer.current_animation = "game_in"
	$AnimationPlayer.play()
	
func start_game():
	current_game.connect("game_over", self, "_on_game_over")
	current_game.set_process(true)
	current_game.set_physics_process(true)
	current_game.set_process_input(true)

func _on_game_over(game_won):
	current_game.disconnect("game_over", self, "_on_game_over")
	current_game.set_process(false)
	current_game.set_physics_process(false)
	current_game.set_process_input(false)
	$AnimationPlayer.current_animation = 'game_out'
	$AnimationPlayer.play()
	yield($AnimationPlayer, "animation_finished")
	
	if game_won:
		score += 1
	else:
		lives -= 1


func _on_TryAgainButton_pressed():
	get_tree().change_scene("res://scenes/GameContainer.tscn")


func _on_QuitButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func update_labels():
	score_label.text ="SCORE: %d" % score
	lives_label.text = "LIVES: %d" % lives
