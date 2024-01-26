extends Area2D

##################################################
######## MELHORAR ESSE CÓDIGO URGENTE ############
##################################################
var TARGET_Y = 248
var TARGET_X = 460
export var SPAWN_Y_A = -13
export var SPAWN_Y_B = 613
export var SPAWN_X_L = -13
export var SPAWN_X_R = 1037
var DIST_TO_TARGET_Y = TARGET_Y - SPAWN_Y_A
var DIST_TO_TARGET_X = TARGET_X - SPAWN_X_L

var SPAWN_A_L = Vector2(460, SPAWN_Y_A)
var SPAWN_A_R = Vector2(564, SPAWN_Y_A)
var SPAWN_B_L = Vector2(460, SPAWN_Y_B)
var SPAWN_B_R = Vector2(564, SPAWN_Y_B)
var SPAWN_L_A = Vector2(SPAWN_X_L, 248)
var SPAWN_L_B = Vector2(SPAWN_X_L, 352)
var SPAWN_R_A = Vector2(SPAWN_X_R, 248)
var SPAWN_R_B = Vector2(SPAWN_X_R, 352)
##################################################

var speed_y: int = 0
var speed_x: int = 0
var hit: bool = false

var above: bool = 0
var left: bool = 0

func _physics_process(delta):
	# faz a nota se mover em direção ao bloco
	if !hit:
		position.y += speed_y * delta
		position.x += speed_x * delta
		if position.y > 280 and position.y < 320:
			queue_free()
		if position.x > 472 and position.x < 522:
			queue_free()
	# faz a mensagem que aparece mexer
	else:
		$Node2D.position.y -= speed_y * delta
		$Node2D.position.x -= speed_x * delta

func initialize(lane):
	above = randi() % 2
	left = randi() % 2
	# lanes de quando está vindo de cima ou de baixo
	if lane == 0:
		if above:
			$AnimatedSprite.animation = "up"
			position = SPAWN_A_L
		else:
			$AnimatedSprite.animation = "left"
			position = SPAWN_B_L
	elif lane == 1:
		if above:
			$AnimatedSprite.animation = "down"
			position = SPAWN_A_R
		else:
			$AnimatedSprite.animation = "right"
			position = SPAWN_B_R
	# lanes de quando está vindo da esquerda ou da direita
	elif lane == 2:
		if left:
			$AnimatedSprite.animation = "up"
			position = SPAWN_L_A
		else:
			$AnimatedSprite.animation = "down"
			position = SPAWN_R_A
	elif lane == 3:
		if left:
			$AnimatedSprite.animation = "left"
			position = SPAWN_L_B
		else:
			$AnimatedSprite.animation = "right"
			position = SPAWN_R_B
			
	else:
		printerr("Lane inválida: " + str(lane))
		return
	
	if lane == 0 or lane == 1:
		speed_y = DIST_TO_TARGET_Y / 2.0
		speed_x = 0
	elif lane == 2 or lane == 3:
		speed_y = 0
		speed_x = DIST_TO_TARGET_X / 2.0
		
	if !above:
		speed_y = -speed_y
	if !left:
		speed_x = -speed_x

func destroy(score):
	# começa a animação da seta sendo destruída
	$AnimatedSprite.visible = false
	# começa o timer pro _on_Timer_timeout
	$Timer.start()
	hit = true
	# imprime uma mensagem com uma cor na tela dependendo
	# de qual foi a classificação da nota tocada
	if score == 3:
		$Node2D/Label.text = "PERFECT"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")

func _on_Timer_timeout():
	queue_free()
