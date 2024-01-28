extends AnimatedSprite

#var isListening = false
#var streamPath = "res://assets/musics/"

func check(event):

	self.animation = "arrow"

	if event == 0:
		self.rotation = 0
#		$nS.stream = load(streamPath + "00.wav")
	if event == 1:
		self.rotation = PI / 2
#		$nS.stream = load(streamPath + "10.wav")
	if event == 2:
		self.rotation = PI
#		$nS.stream = load(streamPath + "01.wav")
	if event == 3:
		self.rotation = -PI / 2
#		$nS.stream = load(streamPath + "11.wav")
