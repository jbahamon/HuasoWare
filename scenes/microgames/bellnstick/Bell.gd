extends RigidBody2D

enum State {TENSE, SPINNING, CAUGHT}
var difficulty = 1.0

func set_difficulty_scale(new_difficulty):
	difficulty = 0.5 + new_difficulty * 0.25
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "swing":
		apply_impulse(Vector2(100, 0), Vector2(0, -420))
		apply_impulse(Vector2(-100, 0), Vector2(0, 420))
		gravity_scale = 30.0 * (difficulty * difficulty)
		
		var horizontal_speed = randf() * -500.0 * difficulty
		
		apply_central_impulse(Vector2(horizontal_speed, -1500.0 * difficulty))


func _on_Stick_hit():	
	queue_free()


func _on_GameOverArea_body_entered(_body):
	queue_free()
