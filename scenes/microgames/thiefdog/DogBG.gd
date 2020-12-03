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
	
	if not did_win:
		$BGSprite.play("surprise")
	
