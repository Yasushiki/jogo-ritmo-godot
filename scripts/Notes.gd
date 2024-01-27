extends AnimatedSprite

var isListening = false
var direction = -1
#var streamPath = "res://assets/musics/"

func _unhandled_input(event):
	if !event.is_action("seta") or self.animation != "idle":
		isListening = false
		return
	
	if !isListening:
		return
	
	self.animation = "arrow"
	
	if event.is_action_pressed("cima", false):
		self.rotation = 0
		direction = 0
#		$nS.stream = load(streamPath + "00.wav")
	if event.is_action_pressed("direita", false):
		self.rotation = PI / 2
		direction = 1
#		$nS.stream = load(streamPath + "10.wav")
	if event.is_action_pressed("baixo", false):
		self.rotation = PI
		direction = 2
#		$nS.stream = load(streamPath + "01.wav")
	if event.is_action_pressed("esquerda", false):
		self.rotation = -PI / 2
		direction = 3
#		$nS.stream = load(streamPath + "11.wav")
	
	isListening = false
	
