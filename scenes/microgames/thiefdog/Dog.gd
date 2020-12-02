extends Node2D
signal try_chomp
signal try_chomp_finish

var did_win

func _ready():
	$Path2D/PathFollow2D.offset = 0.5
	
func try_chomp():
	$Path2D/PathFollow2D.offset = 0.5
	$AnimationPlayer.play("try_chomp")
	emit_signal("try_chomp")

func on_win():
	$AnimationPlayer.play("chomp")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		set_process_input(false)
		try_chomp()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "try_chomp":
		emit_signal("try_chomp_finish", did_win)
