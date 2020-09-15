extends RigidBody2D

enum State {TENSE, SPINNING, CAUGHT}


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "swing":
		apply_impulse(Vector2(100, 0), Vector2(0, -420))
		apply_impulse(Vector2(-100, 0), Vector2(0, 420))
		gravity_scale = 8.0
		
		var horizontal_speed = - 120
		
		apply_central_impulse(Vector2(horizontal_speed, -1000.0))


func _on_Stick_hit(_node):	
	queue_free()

func _on_GameOverArea_body_entered(_body):
	queue_free()
