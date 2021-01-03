class_name StateFactory

var states

func _init():
	states = {
		"idle": IdleState,
		"walk": WalkState,
		"fall": FallState,
		"land": LandState,
		"jump": JumpState,
}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name).new()
	else:
		printerr("No state ", state_name, " in state factory!")
