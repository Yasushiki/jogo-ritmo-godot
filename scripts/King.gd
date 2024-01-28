extends AnimatedSprite

func speak():
	self.animation = "speak"

func laugh(i):
	self.animation = "laugh"
	$King.stream = load("res://assets/musics/kingSounds/laugh.wav")
	$Crowd.stream = load("res://assets/musics/crowdSounds/yeeaaah" + str(i) +".wav")
	$King.play()
	$Crowd.play()
	
func angry():
	self.animation = "angry"
	$King.stream = load("res://assets/musics/kingSounds/frown.wav")
	$Crowd.stream = load("res://assets/musics/crowdSounds/booooh.wav")
	$King.play()
	$Crowd.play()

func _on_King_animation_finished() -> void:
	self.animation = "idle"
