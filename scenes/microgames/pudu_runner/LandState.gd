extends State

class_name LandState

var friction_decay_time = 0.15
var min_abs_speed = 20

func _ready():
	kinematic_body.velocity.y = gravity
	animation_player.play("land")
	var _error = animation_player.connect("animation_finished", self, "landing_finished", [], CONNECT_ONESHOT)


func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		change_state("jump")

		
func _physics_process(delta):
	kinematic_body.velocity.y = gravity
	if not kinematic_body.is_on_floor():
		change_state("fall")
		return
	elif kinematic_body.velocity.x != 0:
		kinematic_body.velocity.x *= (1 - delta/friction_decay_time)
		
		if abs(kinematic_body.velocity.x) < min_abs_speed:
			kinematic_body.velocity.x = 0


func landing_finished(_anim_name):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		change_state("walk")
	else:
		change_state("idle")
