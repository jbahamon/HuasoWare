extends "GenericEnemy.gd"
var movement_velocity = Vector2(-150.0, 0)

func _on_VisibilityNotifier2D_screen_entered():
	$VisibleOnScreenNotifier2D.connect("screen_exited", Callable(self, "_on_VisibilityNotifier2D_screen_exited"))
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func init(params):
	self.position = params.get("position", Vector2.ZERO)


func _physics_process(delta):
	move_and_collide(movement_velocity * delta)
