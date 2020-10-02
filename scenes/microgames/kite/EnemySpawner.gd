extends Node

signal no_more_enemies

var movement = preload("res://scenes/microgames/kite/Enemies/Movement.gd")
var TreeEnemy = preload("res://scenes/microgames/kite/Enemies/TreeEnemy.tscn")
var Birb = preload("res://scenes/microgames/kite/Enemies/Birb.tscn")
var TueTue = preload("res://scenes/microgames/kite/Enemies/TueTue.tscn")
var stopped = false

var spawning_layout = [
	{
		"timestamp": 0.1,
		"type": Birb,
		"elements": [
			{"position": Vector2(0, 240), "frame": 0, "phase": PI},	
			{"position": Vector2(120, 240 + 200.0/PI), "frame": 1, "phase": PI/2.0},
			{"position": Vector2(240, 240), "frame": 2},
		],
		"movement": {
			"type": movement.SineMovement,
			"args": {
				"horizontal_speed": -120,
				"frequency": 0.5, 
				"amplitude": 200, 
				"phase": 0
			},
		}
	},
	{
		"timestamp": 2.0,
		"type": TreeEnemy,
		"elements": [
			{"position": Vector2(0, 500), "frame": 0},	
			{"position": Vector2(80, 520), "frame": 2},
			{"position": Vector2(160, 480), "frame": 1},
			{"position": Vector2(240, 560), "frame": 0},	
			{"position": Vector2(320, 540), "frame": 3},
		],
		"movement": {
			"type": movement.LinearMovement,
			"args": {
				"speed": Vector2(-120, 0)
			},
		}
	},
	
	{
		"timestamp": 4.0,
		"type": TueTue,
		"elements": [
			{"position": Vector2(-60, 160), "secondary_position": Vector2(-180, 160), "movement_time": 0.5},
			{"position": Vector2(0, 320), "secondary_position": Vector2(-180, 320), "movement_time": 1},
		],
		"movement": {
			"type": movement.TwoPointsMovement
		}
	},
	{
		"timestamp": 6.0,
		"type": Birb,
		"elements": [
			{"position": Vector2(0, 120), "frame": 0, "phase": PI},	
			{"position": Vector2(80, 120 + 360*sin(3*PI/4.0)/PI), "frame": 2, "phase": 3*PI/4.0},
			{"position": Vector2(160, 120 + 360.0/PI), "frame": 1, "phase": PI/2.0},
			{"position": Vector2(240, 120 + 360*sin(PI/4.0)/PI), "frame": 0, "phase": PI/4.0},	
			{"position": Vector2(320, 120), "frame": 3},
			{"position": Vector2(0, 360), "frame": 0, "phase": PI},	
			{"position": Vector2(80, 360 + 360*sin(3*PI/4.0)/PI), "frame": 2, "phase": 3*PI/4.0},
			{"position": Vector2(160, 360 + 360.0/PI), "frame": 1, "phase": PI/2.0},
			{"position": Vector2(240, 360 + 360*sin(PI/4.0)/PI), "frame": 0, "phase": PI/4.0},	
			{"position": Vector2(320, 360), "frame": 3},
		],
		"movement": {
			"type": movement.SineMovement,
			"args": {
				"horizontal_speed": -120,
				"frequency": 0.5, 
				"amplitude": 360, 
				"phase": 0
			},
		},
	},
	{
		"timestamp": 9.0,
		"type": TreeEnemy,
		"elements": [
			{"position": Vector2(0, 500), "frame": 0},	
			{"position": Vector2(80, 520), "frame": 2},
			{"position": Vector2(160, 480), "frame": 1},
			{"position": Vector2(240, 560), "frame": 0},	
			{"position": Vector2(320, 540), "frame": 3},
			{"position": Vector2(400, 510), "frame": 0},	
			{"position": Vector2(480, 530), "frame": 2},
			{"position": Vector2(560, 490), "frame": 1},
			{"position": Vector2(0, 500), "frame": 0},	
			{"position": Vector2(80, 520), "frame": 2},
			{"position": Vector2(160, 480), "frame": 1},
			{"position": Vector2(240, 560), "frame": 0},	
			{"position": Vector2(320, 540), "frame": 3},
			{"position": Vector2(400, 510), "frame": 0},	
			{"position": Vector2(480, 530), "frame": 2},
			{"position": Vector2(560, 490), "frame": 1},
		],
		"movement": {
			"type": movement.LinearMovement,
			"args": {
				"speed": Vector2(-120, 0)
			},
		}
	},
	{
		"timestamp": 10.0,
		"type": TueTue,
		"elements": [
			{"position": Vector2(-60, 120), "secondary_position": Vector2(-180, 120), "movement_time": 0.5},
			{"position": Vector2(0, 240), "secondary_position": Vector2(-180, 240), "movement_time": 1},
			{"position": Vector2(60, 360), "secondary_position": Vector2(-180, 360), "movement_time": 1.5},
		],
		"movement": {
			"type": movement.TwoPointsMovement
		}
	},

]


func _ready():
	spawn_enemies()

func stop():
	stopped = true

func spawn_enemies():
	var time = 0
	for spawning_group in spawning_layout:
		yield(get_tree().create_timer(spawning_group.timestamp - time), "timeout")
		
		if stopped:
			return
		
		time = spawning_group.timestamp
		
		for element in spawning_group.elements:
			var instance = spawning_group.type.instance()
			var movement_type = spawning_group.movement.type
			var movement_args
			if "args" in spawning_group.movement:
				movement_args = spawning_group.movement.args
			else:
				movement_args = {}
			var frame
			
			if "frame" in element:
				frame = element.frame
			else:
				frame = 0
				
			instance.position = element.position
			
			instance.set_movement(movement_type.from_args(element, movement_args))
			instance.set_frame(frame)
			add_child(instance)
			
	yield(get_tree().create_timer(10), "timeout")
	if not stopped:
		emit_signal("no_more_enemies")
