extends Node2D

var talk_time = 3.0
var doubt_time = 0.3
var look_time = 1.2

enum State {LOOKING, DOUBTING, TALKING}


@onready var speech: AnimatedSprite2D = $SpeechBubble/Content

var current_state = State.LOOKING
var accumulated_time = 0.0
var current_threshold = randf_range(0.1 * look_time, look_time)

func is_looking():
	return current_state == State.LOOKING
	
func _process(delta):
	accumulated_time += delta
	
	if accumulated_time > current_threshold:
		accumulated_time = 0
		match current_state: 
			State.TALKING:
				$AnimatedSprite2D.animation = "doubt"
				speech.play("dots")
				current_state = State.DOUBTING
				current_threshold = doubt_time
			State.DOUBTING:
				$AnimatedSprite2D.animation = "look"
				speech.play("question")
				current_state = State.LOOKING
				current_threshold = look_time
			State.LOOKING:
				$AnimatedSprite2D.animation = "talk"
				speech.play("default")
				current_state = State.TALKING
				current_threshold = randf_range(0.3 * talk_time, talk_time)

func on_catch_dog():
	$AnimatedSprite2D.animation = "look"
	$SpeechBubble.visible = false
	$AngrySound.play()
	
func freeze():
	set_process(false)
	speech.pause()
	$AnimatedSprite2D.stop()
