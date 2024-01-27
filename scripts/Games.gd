extends Node

# rei vai falar a coisa
# jogador tem 1 segundo para tocar cada nota
# as notas do jogador aparecem embaixo conforme ele toca
# as notas do rei aparecem depois de tocar tudo
# as notas são comparadas
# o rei reage

var arrayKing: Array = [1, 2, 1, 3, 1, 4]
var arrayPlayer: Array = [2, 2, 1, 3, 4, 4]

func _ready():
	pass # Replace with function body.

func createKingNotes(q):
	pass

func _on_BgMusic_finished() -> void:
	$BgMusic.play()
