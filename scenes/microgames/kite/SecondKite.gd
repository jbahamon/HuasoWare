extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "position", position, Vector2(340, 160), 
			4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
