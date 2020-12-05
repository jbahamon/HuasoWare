extends Node2D

func _ready():
	visible = false
	$Shines.visible = false
	

func _on_Dog_try_chomp():
	visible = true
	$BeamCreator.start_spawning()
	

func _on_Dog_try_chomp_finish(did_win):
	$BeamCreator.stop_spawning()
	$Shines.visible = did_win
	visible = did_win


func _on_LadyCloseUp_shake_over():
	visible = true
	$BGSprite.play("surprise")
	
