extends State

class_name WalkState

var walk_speed = 250

func _ready():
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		animation_player.play("walk")
	else:
		change_state("idle")

func _physics_process(_delta):
	kinematic_body.velocity.y = gravity
	if not kinematic_body.is_on_floor():
		change_state("fall")
		
	if Input.is_action_pressed("ui_left"):
		if not animated_sprite.flip_h:
			_flip_direction()
		kinematic_body.velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right"):
		if animated_sprite.flip_h:
			_flip_direction()
		kinematic_body.velocity.x = walk_speed	
	else:
		change_state("idle")	

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		change_state("jump")
		
func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h
	animation_player.play("turn")
