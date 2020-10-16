extends "res://scenes/microgames/Microgame.gd"

export (PackedScene) var SecondKite
signal kite_win
signal kite_lose

func _ready():
	randomize()


func game_over():
	get_tree().call_group("enemies", "stop")
	get_tree().call_group("bullets", "queue_free")
	$EnemySpawner.stop()
	game_won = false
	emit_signal("kite_lose")


func _on_EnemySpawner_no_more_enemies():
	spawn_second_kite()
	yield(get_tree().create_timer(2), "timeout")
	$KitePlayer.move_to_center()

func _on_KitePlayer_finished():
	show_heart()
	game_won = true
	emit_signal("kite_win")

func spawn_second_kite():
	var second_kite = SecondKite.instance()
	second_kite.position = Vector2(700, 160)
	add_child(second_kite)

func show_heart():
	pass

func _on_HUD_message_over():
	emit_signal("game_over", game_won)
