extends Sprite

var talking_images = [
	preload("res://assets/thiefdog/speech/talk1.png"),
	preload("res://assets/thiefdog/speech/talk2.png"),
	preload("res://assets/thiefdog/speech/talk3.png"),
	preload("res://assets/thiefdog/speech/talk4.png"),
	preload("res://assets/thiefdog/speech/talk5.png"),
	preload("res://assets/thiefdog/speech/talk6.png"),
	preload("res://assets/thiefdog/speech/talk7.png"),
	preload("res://assets/thiefdog/speech/talk8.png"),
	preload("res://assets/thiefdog/speech/talk9.png"),
	preload("res://assets/thiefdog/speech/talk10.png"),
	preload("res://assets/thiefdog/speech/talk11.png"),
	preload("res://assets/thiefdog/speech/talk12.png"),
	preload("res://assets/thiefdog/speech/talk13.png"),
	preload("res://assets/thiefdog/speech/talk14.png"),
]

var dots = preload("res://assets/thiefdog/speech/dots.png")
var question_mark = preload("res://assets/thiefdog/speech/question.png")


func _ready():
	talking_images.shuffle()


func on_doubt():
	$Timer.stop()
	$Sprite.texture = dots
	
	
func on_look():
	$Sprite.texture = question_mark
	
	
func on_talk():
	$Timer.start()
	talking_images.push_back(talking_images.pop_front())
	$Sprite.texture = talking_images[0]
	
	
func on_timeout():
	talking_images.push_back(talking_images.pop_front())
	$Sprite.texture = talking_images[0]
	
