extends Node

# rei vai falar a coisa
# jogador tem 1 segundo para tocar cada nota
# as notas do jogador aparecem embaixo conforme ele toca
# as notas do rei aparecem depois de tocar tudo
# as notas são comparadas
# o rei reage

var notes: Array = []
var playerNotes: Array = []
var isListening: bool = false
var qtdInputs := 0

func _ready():
	randomize()
	
func _process(_delta):
	if isListening:
		if Input.is_action_just_pressed("cima"):
			playerNotes.append(0)
			qtdInputs += 1
			getInputs()
		if Input.is_action_just_pressed("direita"):
			playerNotes.append(1)
			qtdInputs += 1
			getInputs()
		if Input.is_action_just_pressed("baixo"):
			playerNotes.append(2)
			qtdInputs += 1
			getInputs()
		if Input.is_action_just_pressed("esquerda"):
			playerNotes.append(3)
			qtdInputs += 1
			getInputs()
	

func _on_BgMusic_finished() -> void:
	$BgMusic.play()

# Começar jogo 
func _on_StartTimer_timeout() -> void:
	game()

func game():
	yield(kingsChoice(), "completed")
	isListening = true
	qtdInputs = 0
	getInputs()

func getInputs():
	if qtdInputs == 4:
		isListening = false
		continueGame()


func continueGame():
	var i = 0
	for note in playerNotes:
		checkInputs(note, i)
		i += 1

func kingsChoice() -> void: 
	# 0 = cima; 1 = direita; 2 = baixo; 3 = esquerda
	notes = []
	for _i in range(4):
		notes.append(randi() % 2) # MUDAR PARA QTD CERTA
	
	for note in notes:
		var pathSound: String = "res://assets/musics/"+ str(note) + str(randi()%2) +".wav"
		$KingsSpeech.stream = load(pathSound)
		$KingsSpeech.play()
		var time: float = $KingsSpeech.stream.get_length() + 0.1
		
		yield(get_tree().create_timer(time), "timeout")


func checkInputs(note, i):
	var currentNote = get_node("Note" + str(i))
	currentNote.check(note)

#func getInputs(n) -> void:
#	var currentNote = get_node("Note" + str(n))
#	currentNote.isListening = true
#
#	yield(get_tree().create_timer(1.0), "timeout")
#
#	if currentNote.animation == "idle":
#		currentNote.animation = "miss"
#	$NoteTimer.start()
#	playerNotes.append(currentNote.direction)
	
#func wait(n):
#	var startTime = OS.get_ticks_msec()
#
#	while OS.get_ticks_msec() - startTime < 2000:
#		var currentNote = get_node("Note" + str(n))
#		if currentNote.animation == "idle":
#			currentNote.isListening = true
#			if currentNote.animation == "idle":
#				currentNote.animation = "miss"
#			playerNotes.append(currentNote.direction)
#	yield(get_tree().create_timer(0.1), "timeout")
