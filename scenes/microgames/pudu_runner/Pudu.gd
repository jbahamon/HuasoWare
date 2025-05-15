extends CharacterBody2D

class_name PersistentState

var state = Node2D.new()
var state_factory

var velocity = Vector2()

func _ready():
	add_child(state)
	state_factory = StateFactory.new()
	change_state("idle")


func change_state(new_state_name):
	remove_child(state)
	state.queue_free()
	state = state_factory.get_state(new_state_name)
	state.name = "current_state"
	state.setup(funcref(self, "change_state"), $AnimationPlayer, $AnimatedSprite2D, self)
	add_child(state)
	
