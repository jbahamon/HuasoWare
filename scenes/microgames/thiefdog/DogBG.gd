extends Node2D

func _ready():
	visible = false
	$Shines.visible = false
	

func enable_beams():
	visible = true
	$BeamCreator.start_spawning()
	$Shines.visible = false

func disable():
	$BeamCreator.stop_spawning()
	$Shines.visible = false
	visible = false
	

func enable_shines():
	visible = true
	$BeamCreator.stop_spawning()
	$Shines.visible = true


func _on_LadyCloseUp_shake_over():
	visible = true
	$BGSprite.play("surprise")
	
