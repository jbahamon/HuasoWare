extends Node

var LayoutGenerator = preload("res://scenes/microgames/kite/LayoutGenerator.gd")

signal no_more_enemies
var stopped = false


func _ready():
	randomize()
	var layout = LayoutGenerator.new(0).get_layout()
	spawn_enemies(layout)

func stop():
	stopped = true

func spawn_enemies(spawning_layout):
	var time = 0
	for spawning_group in spawning_layout:
		await get_tree().create_timer(spawning_group.timestamp - time).timeout
		
		if stopped:
			return
		
		time = spawning_group.timestamp
		
		for element in spawning_group.elements:
			var instance = spawning_group.type.instantiate()
			
			var frame = element.get("frame", 0)
			instance.set_frame(frame)	
			
			var movement_args = spawning_group.get("movement", {})
			instance.init(get_params(element, movement_args))
			
			add_child(instance)
			
	await get_tree().create_timer(5).timeout
	if not stopped:
		emit_signal("no_more_enemies")

func get_params(element, movement_args):
	var params = movement_args.duplicate()
	for key in element:
		params[key] = element[key]
	return params
