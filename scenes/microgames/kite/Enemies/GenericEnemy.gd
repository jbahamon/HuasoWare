extends KinematicBody2D

var movement_strategy

func set_movement(new_movement_strategy):
	self.movement_strategy = new_movement_strategy


func _physics_process(delta):
	move_and_collide(movement_strategy.get_movement(delta))
