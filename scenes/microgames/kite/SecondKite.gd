extends Area2D

func _ready():
	$Tween.interpolate_property(self, "position", position, Vector2(340, 160), 
			4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
