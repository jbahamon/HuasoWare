extends State

class_name FallState

var air_horizontal_speed = 250
var air_friction_decay_time = 0.62

func _ready():
	animation_player.play("fall")

func _physics_process(_delta):
	kinematic_body.velocity.y += gravity
	if kinematic_body.is_on_floor():
		change_state("land")
	
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_right", true):
		animated_sprite.flip_h = false
		kinematic_body.velocity.x = air_horizontal_speed
	
	elif event.is_action_pressed("ui_left", true):
		animated_sprite.flip_h = true
		kinematic_body.velocity.x = -air_horizontal_speed
	
	elif event.is_action_released("ui_right") and not animated_sprite.flip_h:
		kinematic_body.velocity.x = 0
		
	elif event.is_action_released("ui_left") and animated_sprite.flip_h:
		kinematic_body.velocity.x = 0
		
