extends Node2D

var pontos = 0
var combo = 0

var max_combo = 0
var perfect = 0
var good = 0
var ok = 0
var missed = 0

var bpm = 115 # perguntar pro vinícius

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

# a quantidade de elementos desse array depende da métrica da música
# a música de exemplo era 4x4 (eu acho), por isso ela só tinha 4
# spawn_beat, como eu n sei sobre a nossa eu tô deixando mais genérico
var spawn_beat = [0, 0, 1, 0]
var spawn_beat_length = len(spawn_beat)

var lane = 0
var lanes = []
var rand = 0
var note = load("res://scenes/note.tscn")
var instance

func _ready():
	randomize()
	#$Conductor.play_with_beat_offset(8)
	$Conductor.play_from_beat(100, 8)

func _on_Conductor_measure(position):
	for i in range(spawn_beat_length):
		if position == i+1:
			_spawn_notes(spawn_beat[i])
			break

func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_beat[0] = 0
		spawn_beat[1] = 1
		spawn_beat[2] = 1
		spawn_beat[3] = 0
	if song_position_in_beats > 98:
		spawn_beat[0] = 1
		spawn_beat[1] = 0
		spawn_beat[2] = 1
		spawn_beat[3] = 0
	if song_position_in_beats > 132:
		spawn_beat[0] = 1
		spawn_beat[1] = 0
		spawn_beat[2] = 1
		spawn_beat[3] = 0
	if song_position_in_beats > 162:
		spawn_beat[0] = 0
		spawn_beat[1] = 1
		spawn_beat[2] = 1
		spawn_beat[3] = 0
	if song_position_in_beats > 194:
		spawn_beat[0] = 0
		spawn_beat[1] = 0
		spawn_beat[2] = 1
		spawn_beat[3] = 1
	if song_position_in_beats > 228:
		spawn_beat[0] = 1
		spawn_beat[1] = 0
		spawn_beat[2] = 1
		spawn_beat[3] = 0
	if song_position_in_beats > 258:
		spawn_beat[0] = 1
		spawn_beat[1] = 0
		spawn_beat[2] = 0
		spawn_beat[3] = 1
	if song_position_in_beats > 288:
		spawn_beat[0] = 0
		spawn_beat[1] = 1
		spawn_beat[2] = 0
		spawn_beat[3] = 0
	if song_position_in_beats > 322:
		spawn_beat[0] = 1
		spawn_beat[1] = 0
		spawn_beat[2] = 1
		spawn_beat[3] = 1
	if song_position_in_beats > 388:
		spawn_beat[0] = 1
		spawn_beat[1] = 0
		spawn_beat[2] = 1
		spawn_beat[3] = 0
	if song_position_in_beats > 396:
		spawn_beat[0] = 0
		spawn_beat[1] = 1
		spawn_beat[2] = 0
		spawn_beat[3] = 0
	if song_position_in_beats > 404:
		Global.set_score(pontos)
		Global.combo = max_combo
		Global.perfect = perfect
		Global.good = good
		Global.ok = ok
		Global.missed = missed


# spawna uma nota em uma lane aleatória
func _spawn_notes(to_spawn):
	lanes = []
	if to_spawn > 0:
		lane = randi() % 4
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
		lanes.append(lane)
	if to_spawn > 1:
		while to_spawn > 1:
			while lanes.has(rand):
				rand = randi() % 4
			lane = rand
#			lanes.append(lane)
			print(lanes)
			instance = note.instance()
			instance.initialize(lane)
			add_child(instance)
			to_spawn -= 1

func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		perfect += 1
	elif by == 2:
		good += 1
	elif by == 1:
		ok += 1
	else:
		missed += 1
	
	# sistema de pontuação, a gente pode mudar isso depois, eu
	# n jogo jogo de rítmo ent eu n sei como que seria bom
	pontos += by * combo
	$Label.text = str(pontos)
	if combo > 0:
		if max_combo < combo:
			max_combo = combo
			$Combo.text = "Novo combo: " + str(combo)
		else:
			$Combo.text = "Combo: " + str(combo)
	else:
		$Combo.text = ""

func reset_combo():
	combo = 0
	$Combo.text = ""




