extends KinematicBody2D

signal top_fell

export (float) var starting_speed = 0.0
export (float) var input_speed = 0.5
export (float) var gravity_magnitude = 2.0

var angular_velocity = starting_speed
var input_velocity = 0
var time = 0

func _input(event):
	if event.is_action_pressed("ui_left"):
		input_velocity = - input_speed
	elif event.is_action_pressed("ui_right"):
		input_velocity = input_speed
	
		
func _physics_process(delta):
	var gravity = gravity_magnitude * sin(rotation)
	
	angular_velocity += input_velocity
	input_velocity = 0.0
	
	angular_velocity += gravity * delta
	rotation = fposmod(rotation + angular_velocity * delta + PI, 2 * PI) - PI
	
	var collision = move_and_collide(Vector2(0,0))
	
	if collision:
		emit_signal("top_fell")
	 
func _on_game_ended():
	set_process_input(false)
	set_physics_process(false)
