extends AnimationPlayer


func _on_SwingAnimation_animation_finished(anim_name):
	if anim_name == 'swing':
		play("scroll")

