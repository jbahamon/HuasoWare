extends Sprite2D

var velocity = Vector2(10, 0)


func _physics_process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_entered():
	$VisibleOnScreenNotifier2D.connect("screen_exited", Callable(self, "queue_free"))
