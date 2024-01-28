extends AnimatedSprite


func check(event):
	self.animation = "arrow"
	
	if event == -1:
		self.animation = "idle"
	if event == 0:
		self.rotation = 0
	if event == 1:
		self.rotation = PI / 2
	if event == 2:
		self.rotation = PI
	if event == 3:
		self.rotation = -PI / 2
