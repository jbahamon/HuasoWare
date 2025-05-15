extends CharacterBody2D

signal top_fell
@export var input_speed: float = 1
@export var gravity_magnitude: float = 4.0
@export var horizontal_amplitude: float = 60
@export var horizontal_period: float = 4.0

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
	
	var grav_scale = sign(rotation) * pow(abs(rotation) / PI, 0.3)
	var gravity = grav_scale * gravity_magnitude
	
	angular_velocity += input_velocity
	input_velocity = 0.0
	
	angular_velocity += gravity * delta
	rotation = fposmod(rotation + angular_velocity * delta + PI, 2 * PI) - PI
	
	var collision = move_and_collide(
		Vector2(frequency * horizontal_amplitude * cos(frequency * time) * delta, 0)
	)
	
	if collision:
		$AnimatedSprite2D.animation = 'stopped'
		$FallSound.play()
		emit_signal("top_fell")

 
func _on_game_ended():
	set_process_input(false)
	set_physics_process(false)
