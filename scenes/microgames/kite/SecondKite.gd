extends Area2D

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(340, 160), 4)
	
