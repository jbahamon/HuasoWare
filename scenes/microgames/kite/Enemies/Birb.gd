extends "GenericEnemy.gd"

var horizontal_speed = -150
var frequency = 0.5
var amplitude = -200
var accumulated_time = 0

func _on_VisibilityNotifier2D_screen_entered():
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_VisibilityNotifier2D_screen_exited")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	accumulated_time += delta
	move_and_collide(Vector2(horizontal_speed, amplitude * cos(accumulated_time * frequency)) * delta)

func init(params):
	self.position = params.get("position", Vector2.ZERO)
	self.frequency = params.get("frequency",  0.5) * 2 * PI
	self.amplitude = params.get("amplitude", -200)
	var phase = params.get("phase", 0.0)
	self.position.y += amplitude * sin(phase) / PI
	self.accumulated_time = phase / frequency
