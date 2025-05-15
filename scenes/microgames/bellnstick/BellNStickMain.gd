extends "res://scenes/microgames/Microgame.gd"

@export var WinBell: PackedScene

signal win
signal lose

@onready var stick: Area2D = $Stick
@onready var bell: Node2D = $Bell
@onready var follow: PathFollow2D = $SwingPath/PathFollow2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer


var bound: bool
func _ready():
	randomize()
	bound = true
	anim_player.play("swing")
	$Camera2D.make_current()
	$HUD.set_timer_enabled(false)
	
func _process(_delta: float) -> void:
	if bound:
		bell.rotation = follow.rotation


func _on_animation_finished(anim_name):
	match anim_name:
		"swing":
			bound = false
			$SwingPath/PathFollow2D/RemoteTransform2D.update_position = false
			anim_player.play("scroll")
			$Stick.enable()
		"scroll":
			$GameOverArea/CollisionShape2D.disabled = false

func _on_Stick_hit():
	var win_bell = WinBell.instantiate()
	add_child(win_bell)
	win_bell.position = stick.position - Vector2(0, 100)
	anim_player.play("scroll_back")
	
	game_won = true
	$Stick.disable()
	$WinBG.visible = true
	$WinSound.play()
	emit_signal("win")


func _on_GameOverArea_body_entered(_body):
	game_won = false
	$Stick.disable()
	$BGMusic.stop()
	$LoseSound.play()
	emit_signal("lose")


func _on_HUD_message_over():
	emit_signal("game_over", game_won)
