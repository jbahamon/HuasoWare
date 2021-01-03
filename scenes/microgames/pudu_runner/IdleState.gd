extends State

class_name IdleState

var friction_decay_time = 0.12
var min_abs_speed = 20

func _ready():
	animation_player.play("idle")

func _physics_process(delta):
	kinematic_body.velocity.y = gravity
	if not kinematic_body.is_on_floor():
		change_state("fall")
		return
	elif kinematic_body.velocity.x != 0:
		kinematic_body.velocity.x *= (1 - delta/friction_decay_time)
		
		if abs(kinematic_body.velocity.x) < min_abs_speed:
			kinematic_body.velocity.x = 0
	
	
func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h
	animation_player.play("turn")
	set_process_unhandled_input(false)
	yield(animation_player, "animation_finished")
	set_process_unhandled_input(true)
	
	change_state("walk")

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		change_state("jump")
	elif event.is_action_pressed("ui_right", true):
		if animated_sprite.flip_h:
			_flip_direction()
		else:
			change_state("walk")
				
	elif event.is_action_pressed("ui_left", true):
		if not animated_sprite.flip_h:
			_flip_direction()
		else:
			change_state("walk")
