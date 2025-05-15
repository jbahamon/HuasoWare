extends RigidBody2D

enum State {TENSE, SPINNING, CAUGHT}
var difficulty = 1.0
	
	
func set_difficulty_scale(new_difficulty):
	difficulty = 0.5 + new_difficulty * 0.25
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "swing":
		
		apply_impulse(Vector2(0, -420), Vector2(100, 0))
		apply_impulse(Vector2(0, 420), Vector2(-100, 0))
		gravity_scale = 2.5 * (difficulty * difficulty)
		
		var horizontal_speed = randf() * -500.0 * difficulty
		
		apply_central_impulse(Vector2(horizontal_speed, -1500.0 * difficulty))
		
		await get_tree().create_timer(0.25).timeout
		$FallSound.play()

func _on_swing(anim_name):
	if anim_name == "swing":
		await get_tree().create_timer(1.3).timeout
		$SwingSound.play()

func _on_Stick_hit():
	queue_free()
