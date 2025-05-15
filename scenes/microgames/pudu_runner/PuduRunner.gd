extends Node2D

var camera

var sections = [
	preload("res://scenes/microgames/pudu_runner/sections/section0.tscn")
]
var last_section
var all_sections = []

func _ready():
	camera = $Pudu/Camera2D
	last_section = $Section
	last_section.connect("visible", Callable(self, "_spawn_section").bind(), CONNECT_ONE_SHOT)
	all_sections.append(last_section)

func _spawn_section():
	var new_section = sections[randi() % (sections.size())].instantiate()
	new_section.global_position = last_section.get_connector_position()
	new_section.connect("visible", Callable(self, "_spawn_section").bind(), CONNECT_ONE_SHOT)
	new_section.connect("entered_area", Callable(self, "update_camera_bounds"))
	
	all_sections.append(new_section)
	add_child(new_section)
	last_section = new_section
	
	
	
	
	
	
func update_camera_bounds(section, body):
	if body != $Pudu:
		return
	
	camera.limit_bottom = section.position.y + section.get_bottom_bounds()
	
