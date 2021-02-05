extends Sprite

var talking_images = [
	preload("res://assets/thief_dog/speech/talk1.png"),
	preload("res://assets/thief_dog/speech/talk2.png"),
	preload("res://assets/thief_dog/speech/talk3.png"),
	preload("res://assets/thief_dog/speech/talk4.png"),
	preload("res://assets/thief_dog/speech/talk5.png"),
	preload("res://assets/thief_dog/speech/talk6.png"),
	preload("res://assets/thief_dog/speech/talk7.png"),
	preload("res://assets/thief_dog/speech/talk8.png"),
	preload("res://assets/thief_dog/speech/talk9.png"),
	preload("res://assets/thief_dog/speech/talk10.png"),
	preload("res://assets/thief_dog/speech/talk11.png"),
	preload("res://assets/thief_dog/speech/talk12.png"),
	preload("res://assets/thief_dog/speech/talk13.png"),
	preload("res://assets/thief_dog/speech/talk14.png"),
]

var dots = preload("res://assets/thief_dog/speech/dots.png")
var question_mark = preload("res://assets/thief_dog/speech/question.png")


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
	
