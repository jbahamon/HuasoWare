class LinearMovement:
	var velocity
	
	func _init(new_velocity):
		velocity = new_velocity + Vector2.ZERO
	
	
	func get_movement(position, delta):
		return velocity * delta


	static func from_args(element, args):
		if "speed" in element:
			return LinearMovement.new(element.speed)
		else:
			return LinearMovement.new(args.speed)	


class SineMovement:
	var frequency
	var amplitude
	var accumulated_time
	var horizontal_speed
	
	
	func _init(new_horizontal_speed, new_frequency, new_amplitude, phase):
		self.horizontal_speed = new_horizontal_speed
		self.frequency = new_frequency * 2* PI
		self.amplitude = new_amplitude
		self.accumulated_time = phase / frequency
	
	
	func get_movement(position, delta):
		accumulated_time += delta
		return Vector2(horizontal_speed, amplitude * cos(accumulated_time * frequency)) * delta
	
	
	static func from_args(element, args):
		var new_horizontal_speed
		var new_frequency
		var new_amplitude
		var phase
		
		if "horizontal_speed" in element:
			new_horizontal_speed = element.horizontal_speed
		else:
			new_horizontal_speed = args.horizontal_speed
		
		if "frequency" in element:
			new_frequency = element.frequency
		else:
			new_frequency = args.frequency
			
		if "amplitude" in element:
			new_amplitude = element.amplitude
		else:
			new_amplitude = args.amplitude
			
		if "phase" in element:
			phase = element.phase
		else:
			phase = args.phase
			
		return SineMovement.new(new_horizontal_speed, new_frequency, new_amplitude, phase)


class TwoPointsMovement:
	var velocity
	var destination
	var accumulated_time
	var max_time
	
	func _init(point1, point2, time):
		self.accumulated_time = 0
		self.destination = point2
		self.velocity = (point2 - point1)/float(time)
		self.max_time = time
	
	
	func get_movement(position, delta):
		self.accumulated_time += delta
		
		
		if accumulated_time > self.max_time:
			return self.destination - position
		else:
			return self.velocity * delta
	
	static func from_args(element, args):
		var position
		var args_destination
		var movement_time
		
		if "position" in element:
			position = element.position
		else:
			position = args.position
		
		if "secondary_position" in element:
			args_destination = element.secondary_position
		else:
			args_destination = args.secondary_position
		
		if "movement_time" in element:
			movement_time = element.movement_time
		else:
			movement_time = args.movement_time
		
		return TwoPointsMovement.new(position, args_destination, movement_time)
