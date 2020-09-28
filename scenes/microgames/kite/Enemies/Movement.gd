class LinearMovement:
	var velocity
	
	func _init(horizontal_speed, vertical_speed):
		velocity = Vector2(horizontal_speed, vertical_speed)
	
	
	func get_movement(delta):
		return velocity * delta


	static func from_args(args):
		return LinearMovement.new(args.speed.x, args.speed.y)


class SineMovement:
	var frequency
	var amplitude
	var accumulated_time
	var horizontal_speed
	
	
	func _init(horizontal_speed, frequency, amplitude, phase):
		self.horizontal_speed = horizontal_speed
		self.frequency = frequency * 2 * PI
		self.amplitude = amplitude
		self.accumulated_time = phase * frequency
	
	
	func get_movement(delta):
		accumulated_time += delta
		return Vector2(horizontal_speed, amplitude * sin(accumulated_time * frequency)) * delta
	
	
	static func from_args(args):
		return SineMovement.new(args.horizontal_speed, args.frequency, 
				args.amplitude, args.phase)
