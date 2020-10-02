extends RigidBody2D

func _ready():
	var direction = (get_node("../../../KitePlayer").global_position - global_position).normalized()
	linear_velocity = 320 * direction
