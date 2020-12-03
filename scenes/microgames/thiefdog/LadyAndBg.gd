extends Node2D

var talk_time = 3.0
var doubt_time = 0.3
var look_time = 1.2

enum State {LOOKING, DOUBTING, TALKING}

var current_state = State.LOOKING
var accumulated_time = 0.0
var current_threshold = rand_range(0.1 * look_time, look_time)

func is_looking():
	return current_state == State.LOOKING
	
func _process(delta):
	accumulated_time += delta
	
	if accumulated_time > current_threshold:
		accumulated_time = 0
		match current_state: 
			State.TALKING:
				$AnimatedSprite.animation = "doubt"
				$SpeechBubble.on_doubt()
				current_state = State.DOUBTING
				current_threshold = doubt_time
			State.DOUBTING:
				$AnimatedSprite.animation = "look"
				$SpeechBubble.on_look()
				current_state = State.LOOKING
				current_threshold = look_time
			State.LOOKING:
				$AnimatedSprite.animation = "talk"
				$SpeechBubble.on_talk()
				current_state = State.TALKING
				current_threshold = rand_range(0.3 * talk_time, talk_time)

func on_catch_dog():
	$AnimatedSprite.animation = "look"
	$SpeechBubble.visible = false
	
