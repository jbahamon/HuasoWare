extends Node

var movement = preload("res://scenes/microgames/kite/Enemies/Movement.gd")
var TreeEnemy = preload("res://scenes/microgames/kite/Enemies/TreeEnemy.tscn")
var Birb = preload("res://scenes/microgames/kite/Enemies/TreeEnemy.tscn")
var TueTue = preload("res://scenes/microgames/kite/Enemies/TreeEnemy.tscn")


var spawning_layout = [
	{
		"timestamp": 2.0,
		"type": TreeEnemy,
		"layout": [
				Vector2(0, 240),
				Vector2(20, 240),
				Vector2(40, 240),
			],
		"movement": {
			"type": movement.LinearMovement,
			"args": {
				"speed": Vector2(-20, 0)
			}
		}
	}
]


func _ready():
	spawn_enemies()
	

func spawn_enemies():
	var time = 0
	for spawning_group in spawning_layout:
		yield(get_tree().create_timer(spawning_group.timestamp - time), "timeout")
		time += spawning_group.timestamp
		
		for location in spawning_group.layout:
			var instance = spawning_group.type.instance()
			var movement_type = spawning_group.movement.type
			var movement_args = spawning_group.movement.args
			
			instance.position = location
			
			instance.set_movement(movement_type.from_args(movement_args))
			
			add_child(instance)
			print("Hello")
		
