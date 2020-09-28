extends Area2D

export var max_speed = 300.0
export var acceleration = 1200.0
export var margin = 0.1


var current_velocity = Vector2(0, 0)
var disable_controls := false
onready var screen_size = get_viewport_rect().size


func _process(delta):
	
	if disable_controls:
		return
	
	var acceleration_direction = Vector2(0, 0)
	if Input.is_action_pressed("ui_right"):
		acceleration_direction.x += 1
	
	if Input.is_action_pressed("ui_left"):
		acceleration_direction.x -= 1
		
	if Input.is_action_pressed("ui_down"):
		acceleration_direction.y += 1
	
	if Input.is_action_pressed("ui_up"):
		acceleration_direction.y -= 1
	
	if acceleration_direction.length() > 0:
		acceleration_direction = acceleration_direction.normalized()
		current_velocity += acceleration_direction * delta * acceleration
		current_velocity = current_velocity.clamped(max_speed)
	elif current_velocity.length() > acceleration:
		current_velocity += - current_velocity.normalized() * delta * acceleration
	elif current_velocity.length() > 0:
		current_velocity = Vector2(0, 0)
	
	position += current_velocity * delta
	position.x = clamp(position.x, margin * screen_size.x, 
			(1.0 - margin) * screen_size.x)
	position.y = clamp(position.y, margin * screen_size.y, 
			(1.0 - margin) * screen_size.y)
