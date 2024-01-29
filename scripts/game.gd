extends Node

var notes: Array = []
var playerNotes: Array = []
var isListening: bool = false
var qtdInputs := 0
var currentScore := 0
var score := 0
var run := 0
var kingNode
var boogaNode

func _ready():
	randomize()
	kingNode = get_node("King/King")
	boogaNode = get_node("Booga/Booga")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), 3)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Player"), 6)
	
func _process(_delta):
	if isListening:
		if Input.is_action_just_pressed("cima"):
			playerNotes.append(0)
			qtdInputs += 1
			$PlayerSpeech.stream = load("res://assets/musics/up.wav")
			$PlayerSpeech.play()
			getInputs()
		if Input.is_action_just_pressed("direita"):
			playerNotes.append(1)
			qtdInputs += 1
			$PlayerSpeech.stream = load("res://assets/musics/right.wav")
			$PlayerSpeech.play()
			getInputs()
		if Input.is_action_just_pressed("baixo"):
			playerNotes.append(2)
			qtdInputs += 1
			$PlayerSpeech.stream = load("res://assets/musics/down.wav")
			$PlayerSpeech.play()
			getInputs()
		if Input.is_action_just_pressed("esquerda"):
			playerNotes.append(3)
			qtdInputs += 1
			$PlayerSpeech.stream = load("res://assets/musics/left.wav")
			$PlayerSpeech.play()
			getInputs()

func _on_BgMusic_finished() -> void:
	$BgMusic.play()

# Começar jogo 
func _on_StartTimer_timeout() -> void:
	game()


## FLUXO DE JOGO ##
func game():
	# Faz o rei falar, e pausa o código até ele terminar
	yield(kingsChoice(), "completed")
	
	# Começa a escutar os inputs e reseta a qtd de inputs
	isListening = true
	boogaNode.isListening = true
	qtdInputs = 0
	getInputs()

func kingsChoice() -> void: 
	# 0 = cima; 1 = direita; 2 = baixo; 3 = esquerda
	notes = []
	for _i in range(4):
		notes.append(randi() % 4)
	
	for note in notes:
		var variations = 2 # quantidade de variações de cada nota
		var pathSound: String = "res://assets/musics/"+ str(note) + str(randi()%variations) + ".wav"
		$KingsSpeech.stream = load(pathSound)
		$KingsSpeech.play()
		kingNode.speak()
		
		yield(get_tree().create_timer(1.0), "timeout")

func getInputs():
	# verifica se os 4 inputs já foram informados
	if qtdInputs == 4:
		isListening = false
		boogaNode.isListening = false
		continueGame()

func continueGame():
	# passa pelas notas e muda o sprite delas
	var i = 0
	for note in playerNotes:
		checkInputs(note, i, 0)
		i += 1
	
	# mostra as teclas que o rei falou
	i = 0
	for note in notes:
		var kingCurrentNote = get_node("NotesKing/NoteKing" + str(i))
		kingCurrentNote.visible = true
		checkInputs(note, i, 1)
		i += 1
	
	
	compareNotes()
	yield(get_tree().create_timer(3), "timeout")
	
	# aumenta mais 1 na qtd de runs
	run += 1
	
	# faz mais uma partida se n foram 4 partidas 
	if run != 4:
		resetVariables()
		$StartTimer.start()
	else:
		Global.score = score
		if score < 10:
			get_tree().change_scene("res://scenes/GameOverScreen.tscn")
		else:
			get_tree().change_scene("res://scenes/GameWinScreen.tscn")

func compareNotes():
	# verifica a pontuação
	for j in range(4):
		if notes[j] == playerNotes[j]:
			currentScore += 1
	score += currentScore
	
	# rei/plateia tem a reação de acordo com seus pontos
	if currentScore == 4:
		kingNode.laugh(1)
	elif currentScore == 3:
		kingNode.laugh(2)
	else:
		kingNode.angry()

func resetVariables():
	notes = []
	playerNotes = []
	for i in range(4):
		checkInputs(-1, i, 0)
		checkInputs(-1, i, 1)
	currentScore = 0
## FLUXO DE JOGO ##


func checkInputs(note, i, k):
	var path = "Notes/Note"
	if k:
		path = "NotesKing/NoteKing"
		
	var currentNote = get_node(path + str(i))
	currentNote.check(note)
	
	if k and note == -1:
		currentNote.visible = false
	
