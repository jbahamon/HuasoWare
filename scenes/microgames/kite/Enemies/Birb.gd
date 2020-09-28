extends "GenericEnemy.gd"
var movement = preload("res://scenes/microgames/kite/Enemies/Movement.gd")

func _ready():
	if movement_strategy == null:
		movement_strategy = movement.SineMovement.new(50, 0.5, -200, 0)
	

func _on_VisibilityNotifier2D_screen_entered():
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_VisibilityNotifier2D_screen_exited")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
