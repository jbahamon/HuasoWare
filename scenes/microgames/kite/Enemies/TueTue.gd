extends "GenericEnemy.gd"
export (PackedScene) var TueTueBullet

var movement = preload("res://scenes/microgames/kite/Enemies/Movement.gd")
enum State {POSITIONING, PRE_SHOOTING, POST_SHOOTING, CHASING_PLAYER}
var pre_shooting_time = 1
var post_shooting_time = 1.5
var accumulated_time = 0
var current_state = State.POSITIONING
var direction

func _ready():
	if movement_strategy == null:
		movement_strategy = movement.TwoPointsMovement.new(
				position, position + Vector2(-60, 0), 1)
	

func _on_VisibilityNotifier2D_screen_entered():
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_VisibilityNotifier2D_screen_exited")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func move(delta):
	if stopped:
		return
		
	match current_state:
		State.POSITIONING:
			var displacement = movement_strategy.get_movement(position, delta)
			move_and_collide(displacement)
			if displacement.length() == 0.0:
				current_state = State.PRE_SHOOTING
		State.PRE_SHOOTING:
			accumulated_time += delta
			if accumulated_time >= pre_shooting_time:
				add_child(TueTueBullet.instance())
				current_state = State.POST_SHOOTING
		State.POST_SHOOTING:
			accumulated_time += delta
			if accumulated_time >= post_shooting_time:
				direction = (get_node("../../KitePlayer").global_position - global_position).normalized()
				current_state = State.CHASING_PLAYER
		State.CHASING_PLAYER:
			move_and_collide(350 * direction * delta)
