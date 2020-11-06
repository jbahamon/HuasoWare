extends KinematicBody2D

signal top_fell
export (float) var input_speed = 1
export (float) var gravity_magnitude = 4.0
export (float) var horizontal_amplitude = 60
export (float) var horizontal_period = 4.0

var input_velocity = 0
var angular_velocity = 0
var time = 0
var frequency = 0

func _ready():
	frequency = 2 * PI / horizontal_period
	rotation = PI/32.0 * (1 + randf())
	
	if randi() % 2 == 0:
		rotation = -rotation

func _input(event):
	if event.is_action_pressed("ui_left") and not event.is_action_pressed("ui_right"):
		input_velocity = - input_speed
	elif event.is_action_pressed("ui_right") and not event.is_action_pressed("ui_left"):
		input_velocity = input_speed


func _physics_process(delta):
	time += delta
	
	var gravity = get_gravity()
	
	angular_velocity += input_velocity
	input_velocity = 0.0
	
	angular_velocity += gravity * delta
	rotation = fposmod(rotation + angular_velocity * delta + PI, 2 * PI) - PI
	
	var collision = move_and_collide(
			Vector2(frequency * horizontal_amplitude * cos(frequency * time) * delta, 0)
	)
	
	if collision:
		emit_signal("top_fell")

 
func _on_game_ended():
	set_process_input(false)
	set_physics_process(false)

func get_gravity():
	var scale = sign(rotation) * pow(abs(rotation) / PI, 0.3)
	return scale * gravity_magnitude
