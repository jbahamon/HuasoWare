extends RigidBody2D

enum State {TENSE, SPINNING, CAUGHT}

export var spinning_speed = 1.2
var current_state = State.TENSE

func _process(delta):
	match current_state:
		State.TENSE:
			rotation = 0
		State.SPINNING:
			rotation -= spinning_speed * delta
		State.CAUGHT:
			rotation = 0
