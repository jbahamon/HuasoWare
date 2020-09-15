extends RemoteTransform2D

func _on_SwingAnimation_animation_finished(anim_name):
	if anim_name == 'swing':
		update_position = false
		update_rotation = false
