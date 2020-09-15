extends Node

export (PackedScene) var WinBell

signal emboque_win
signal emboque_lose

func _ready():
	randomize()

func _on_Stick_hit(_stick):
	emit_signal("emboque_win")
	var bell = WinBell.instance()
	add_child(bell)
	bell.position = $Stick.position - Vector2(0, 100)
	$GeneralAnimation.play("scroll_back")
	
func _on_GameOverArea_body_entered(_body):
	emit_signal("emboque_lose")
