extends Area2D

export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 800

func _process(delta):
	if Input.is_action_pressed("cima"):
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = 0
		$Timer.start()
	if Input.is_action_pressed("direita"):
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = PI / 2
		$Timer.start()
	if Input.is_action_pressed("baixo"):
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = PI
		$Timer.start()
	if Input.is_action_pressed("esquerda"):
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = -PI / 2
		$Timer.start()
	
	position.y += speed * delta


func _on_Timer_timeout():
	queue_free()
