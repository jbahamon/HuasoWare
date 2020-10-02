extends Area2D

signal finished
signal hit

export var max_speed = 300.0
export var acceleration = 2200.0
export var margin = 0.1


var current_velocity = Vector2(0, 0)
var disable_controls := false
onready var screen_size = get_viewport_rect().size

func _ready():
	$CollisionShape2D.set_deferred("disabled", true)

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
	
	if current_velocity.x >= 0:
		$LinePivot.scale.x = 1
		$ScarfPivot.scale.x = 1
	else:
		$LinePivot.scale.x = -1
		$ScarfPivot.scale.x = -1
		
	if current_velocity.y <= 0:
		$LinePivot.scale.y = 1
		$ScarfPivot.scale.y = 1
	else:
		$LinePivot.scale.y = -1
		$ScarfPivot.scale.y = -1
	
	position += current_velocity * delta
	position.x = clamp(position.x, margin * screen_size.x, 
			(1.0 - margin) * screen_size.x)
	position.y = clamp(position.y, margin * screen_size.y, 
			(1.0 - margin) * screen_size.y)


func _on_KitePlayer_body_entered(body):
	get_sad()
	disable_controls = true
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func get_sad():
	$Kite.animation = "flying"

func move_to_center():
	disable_controls = true
	$Tween.interpolate_property(self, "position", position, Vector2(300, 160), 
			2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func _on_moved_to_center(object, key):
	emit_signal("finished")
