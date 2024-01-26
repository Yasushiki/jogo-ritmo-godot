extends AnimatedSprite

var perfect = false
var good = false
var ok = false
var current_note = null

export var input = ""

func _unhandled_input(event):
	if !event.is_action(input):
		return

	if event.is_action_pressed(input, false):
		if current_note != null:
			if perfect:
				get_parent().increment_score(3)
				# a função destroy está definida em note.tscn
				# current_note é uma instância dessa cena
				current_note.destroy(3)
			elif good:
				get_parent().increment_score(2)
				current_note.destroy(2)
			elif ok:
				get_parent().increment_score(1)
				current_note.destroy(1)
		else:
			get_parent().increment_score(0)
	# verifica se o jogador apertou a tecla e muda o frame atual
	if event.is_action_pressed(input):
		frame = 1
	# verifica se o jog soltou a tecla e muda o frame um tempo depois
	if event.is_action_released(input):
		$PushTimer.start()

func _reset():
	perfect = false
	good = false
	ok = false
	current_note = null

## Perfect ##
func _on_PerfectArea_area_entered(note):
	if note.is_in_group("note"):
		perfect = true
func _on_PerfectArea_area_exited(note):
	if note.is_in_group("note"):
		perfect = false

## Good ##
func _on_GoodArea_area_entered(note):
	if note.is_in_group("note"):
		good = true
func _on_GoodArea_area_exited(note):
	if note.is_in_group("note"):
		good = false

## Ok ##
func _on_OkArea_area_entered(note):
	if note.is_in_group("note"):
		good = true
		# quando uma nota entra na área do Ok, ela vira a nota atual
		# "current_note = note" faz com que a variável current_note
		# vire uma instância da cena note.tscn 
		#
		# Problema: desse jeito só tem uma "nota atual", então se
		# duas notas estiverem descendo, o jogador vai ter que
		# tocar as notas numa ordem em específico
		# Solução: implementar uma forma de ter uma nota atual para
		# cada variação da nota (cima, baixo, esqueda, direita)
		current_note = note
func _on_OkArea_area_exited(note):
	if note.is_in_group("note"):
		good = false
		# quando a nota atual sai da área do Ok, ela deixa de ser a
		# nota atual, já que n dá mais pra tocar ela
		current_note = null


## Timer ##
func _on_PushTimer_timeout():
	# muda o frame pro frame 0 depois de 0,05s (pode alterar o tempo)
	frame = 0
