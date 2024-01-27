extends Node

# rei vai falar a coisa
# jogador tem 1 segundo para tocar cada nota
# as notas do jogador aparecem embaixo conforme ele toca
# as notas do rei aparecem depois de tocar tudo
# as notas são comparadas
# o rei reage

var notes: Array = []
var playerNotes: Array = []

func _ready():
	randomize()

func _on_BgMusic_finished() -> void:
	$BgMusic.play()

# Começar jogo 
func _on_StartTimer_timeout() -> void:
	game()

func game():
	yield(kingsChoice(), "completed")
	
#	$Label.text = "JÁ PODE VAI LOGO VAI VAI VAI"
#	
	for i in range(4):
		yield(getInputs(i), "completed")
#		getInputs(i)
#	yield(getInputs(0), "completed")
#	$Label.text = "0"
#	yield(getInputs(1), "completed")
#	$Label.text = "1"
#	yield(getInputs(2), "completed")
#	$Label.text = "2"
#	yield(getInputs(3), "completed")
#	$Label.text = "3"
	
	print(playerNotes)

func kingsChoice() -> void: 
	# 0 = cima; 1 = direita; 2 = baixo; 3 = esquerda
	notes = []
	for _i in range(4):
		notes.append(randi() % 2) # MUDAR PARA QTD CERTA
	
	for note in notes:
		var pathSound: String = "res://assets/musics/"+ str(note) + str(randi()%2) +".wav"
		$AudioStreamPlayer.stream = load(pathSound)
		$AudioStreamPlayer.play()
		var time: float = $AudioStreamPlayer.stream.get_length() + 0.1
		
		yield(get_tree().create_timer(time), "timeout")
	
	#flag = true

func getInputs(n) -> void:
	var currentNote = get_node("Note" + str(n))
	currentNote.isListening = true
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	if currentNote.animation == "idle":
		currentNote.animation = "miss"
	
	playerNotes.append(currentNote.direction)

	
