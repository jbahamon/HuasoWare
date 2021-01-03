extends Node2D

class_name State

var gravity = 15
var _change_state: FuncRef
var animation_player: AnimationPlayer
var animated_sprite: AnimatedSprite
var kinematic_body: KinematicBody2D

# Writing _delta instead of delta here prevents the unused variable warning.
func _physics_process(_delta):
	kinematic_body.move_and_slide(kinematic_body.velocity, Vector2.UP)

func setup(change_state, animation_player, animated_sprite, kinematic_body):
	self._change_state = change_state
	self.animation_player = animation_player
	self.animated_sprite = animated_sprite
	self.kinematic_body = kinematic_body

func facing():
	if animated_sprite.flip_h:
		return -1
	else:
		return 1
		

		
func change_state(state_name):
	_change_state.call_func(state_name)
