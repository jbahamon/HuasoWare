extends KinematicBody2D

var movement_strategy
var stopped = false

func set_movement(new_movement_strategy):
	self.movement_strategy = new_movement_strategy


func _physics_process(delta):
	move(delta)
	
func move(delta):
	if not stopped:
		move_and_collide(movement_strategy.get_movement(position, delta))
		
func stop():
	stopped = true

func set_frame(i):
	$AnimatedSprite.set_frame(i)
