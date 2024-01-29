extends TextureRect

var score = Global.score

func _ready() -> void:
	$Label.text = "SCORE: " + str(score)

func _on_ButtonMenu_pressed() -> void:
	get_tree().change_scene("res://scenes/Main.tscn")
