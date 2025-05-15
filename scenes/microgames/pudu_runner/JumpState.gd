extends State

class_name JumpState

var horizontal_speed = 200
var jump_velocity = Vector2(0, -400)
var max_jump_time = 2
var accumulated_time

func _ready():
	set_process_unhandled_input(false)
	kinematic_body.velocity.x /= 2
	kinematic_body.velocity.y = 0
	accumulated_time = 0
	animation_player.play("jump")
	
	await get_tree().create_timer(0.15).timeout
	
	perform_jump()

func _physics_process(_delta):
	kinematic_body.velocity.y += gravity
	if is_processing_unhandled_input() and kinematic_body.velocity.y > 0:
		change_state("fall")

func perform_jump():
	if Input.is_action_pressed("ui_left"):
		animated_sprite.flip_h = true
		jump_velocity.x = -horizontal_speed
	elif Input.is_action_pressed("ui_right"):
		animated_sprite.flip_h = false
		jump_velocity.x = horizontal_speed
		
	kinematic_body.velocity = jump_velocity
	set_process_unhandled_input(true)

func _unhandled_input(event):
	
	if event.is_action_pressed("ui_right", true):
		animated_sprite.flip_h = false
		kinematic_body.velocity.x = horizontal_speed
	
	elif event.is_action_pressed("ui_left", true):
		animated_sprite.flip_h = true
		kinematic_body.velocity.x = -horizontal_speed 
	
	elif event.is_action_released("ui_right") and not animated_sprite.flip_h:
		kinematic_body.velocity.x = 0
		
	elif event.is_action_released("ui_left") and animated_sprite.flip_h:
		kinematic_body.velocity.x = 0
	
