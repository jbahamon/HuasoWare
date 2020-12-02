extends Sprite

func _ready():
	visible = false
	$Shines.visible = false

func _on_Dog_try_chomp():
	visible = true
	$BeamCreator.start_spawning()
	


func _on_Dog_try_chomp_finish(did_win):
	if did_win:
		$BeamCreator.stop_spawning()
		$Shines.visible = true
