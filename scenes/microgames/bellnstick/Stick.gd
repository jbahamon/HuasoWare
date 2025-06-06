extends Area2D

signal hit

@export var speed = 200
@export var left_margin = 0.1
@export var right_margin = 0.1

var disable_controls := false
var screen_size


func _ready():
	disable()
	screen_size = get_viewport_rect().size

func _process(delta):
	
	if disable_controls:
		return
	
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction += 1
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		
	position.x += direction * speed * delta
	position.x = clamp(position.x, screen_size.x * left_margin, 
			screen_size.x * (1 - right_margin))


func _on_Stick_body_entered(_body):
	emit_signal("hit")

func enable():
	$AnimationPlayer.play("arrows_fade_in")
	disable_controls = false
	$Arrows/LeftArrow.frame = 0
	$Arrows/RightArrow.frame = 0
	$Arrows/LeftArrow.play()
	$Arrows/RightArrow.play()
	$CollisionShape2D.set_deferred("disabled", false)


func disable():
	$AnimationPlayer.play("arrows_fade_out")
	disable_controls = true
	$CollisionShape2D.set_deferred("disabled", true)
