extends Area2D

export var speed = 1
export var animacao = "cima"

func _ready():
	if animacao == "cima":
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = 0
	if animacao == "direita":
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = PI / 2
	if animacao == "baixo":
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = PI
	if animacao == "esquerda":
		$AnimatedSprite.animation = "arrow"
		$AnimatedSprite.rotation = -PI / 2
	

func _on_Timer_timeout():
	queue_free()
