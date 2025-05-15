extends Node2D

var BeamEffect = preload("res://scenes/microgames/thief_dog/BeamEffect.tscn")
var n_beams = 0

@export var beam_velocity: float = 20
@export var parent_node_path: NodePath
@export var max_beams = 20
@export var size: Vector2 = Vector2(640, 480)

var parent_node
func _ready():
	parent_node = get_node(parent_node_path)
	set_process(false)	
	
func start_spawning():
	set_process(true)
	
	for _i in range(max_beams):
		var beam = spawn_beam()
		beam.position.x = randf_range(0, size.x)


func stop_spawning():
	set_process(false)
	get_tree().call_group("BeamFX", "queue_free")
	
	
func spawn_beam():
	var beam = BeamEffect.instantiate()
	var beam_scale = randf_range(0.4, 1)
	beam.scale = Vector2(beam_scale, beam_scale * 0.5)
	beam.position = Vector2(-118 * beam_scale, randf_range(0, size.y)) 
	beam.velocity = Vector2(beam_velocity * beam_scale, 0)
	parent_node.call_deferred("add_child", beam)
	beam.connect("tree_exited", Callable(self, "on_beam_destroyed"))
	return beam


func on_beam_destroyed():
	if self.is_processing():
		spawn_beam()
