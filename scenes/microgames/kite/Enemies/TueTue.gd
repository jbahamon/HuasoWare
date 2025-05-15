extends "GenericEnemy.gd"
@export var TueTueBullet: PackedScene

enum State {POSITIONING, PRE_SHOOTING, POST_SHOOTING, CHASING_PLAYER}


var accumulated_time = 0
var current_state = State.POSITIONING

var positioning_time = 1
var positioning_destination
var positioning_velocity

var pre_shooting_time = 0.5
var post_shooting_time = 0.5

var chase_speed = 350
var chase_direction

func _on_VisibilityNotifier2D_screen_entered():
	$VisibleOnScreenNotifier2D.connect("screen_exited", Callable(self, "_on_VisibilityNotifier2D_screen_exited"))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	accumulated_time += delta
	match current_state:
		State.POSITIONING:
			if self.accumulated_time < self.positioning_time:
				move_and_collide(self.positioning_velocity * delta)
			else:
				self.accumulated_time = 0
				move_and_collide(self.positioning_destination - self.position)
				current_state = State.PRE_SHOOTING
		State.PRE_SHOOTING:
			move_and_collide(Vector2.ZERO)
			if accumulated_time >= pre_shooting_time:
				self.accumulated_time = 0
				add_child(TueTueBullet.instantiate())
				current_state = State.POST_SHOOTING
		State.POST_SHOOTING:
			move_and_collide(Vector2.ZERO)
			if accumulated_time >= post_shooting_time:
				self.accumulated_time = 0
				chase_direction = (get_node("../../KitePlayer").global_position - global_position).normalized()
				current_state = State.CHASING_PLAYER
		State.CHASING_PLAYER:
			move_and_collide(chase_speed * chase_direction * delta)

func init(params):
	self.position = params.get("point1")
	self.positioning_destination = params.get("point2")
	self.positioning_time = params.get("positioning_time", 1)
	self.positioning_velocity = (positioning_destination - position)/float(self.positioning_time)
	self.current_state = State.POSITIONING
	self.accumulated_time = 0
