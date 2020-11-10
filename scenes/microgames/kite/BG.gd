extends Node2D

onready var bgs = [$Sprite, $Sprite2, $Sprite3]

func _process(delta):
	for bg in bgs:
		bg.position.x -= 20 * delta
		
	if bgs[0].position.x <= -320:
		var bg = bgs.pop_front()
		bg.position += 3 * 320
		bgs.push_back(bg)
