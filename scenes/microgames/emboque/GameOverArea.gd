extends Area2D


func _on_SwingAnimation_animation_finished(anim_name):
	if anim_name == 'swing':
		$CollisionShape2D.disabled = false
