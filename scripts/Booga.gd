extends AnimatedSprite

var isListening: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if !event.is_action("seta") or !isListening:
		return
	
	if event.is_action_pressed("cima"):
		self.animation = "up"
	if event.is_action_pressed("direita"):
		self.animation = "right"
	if event.is_action_pressed("baixo"):
		self.animation = "down"
	if event.is_action_pressed("esquerda"):
		self.animation = "left"

func _on_Booga_animation_finished() -> void:
	self.animation = "idle"
