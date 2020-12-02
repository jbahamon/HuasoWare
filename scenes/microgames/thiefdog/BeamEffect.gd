extends Sprite

var velocity = Vector2(10, 0)


func _physics_process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_entered():
	$VisibilityNotifier2D.connect("screen_exited", self, "queue_free")
