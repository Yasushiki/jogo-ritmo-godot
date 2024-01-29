extends CanvasLayer


func _on_StartButton_pressed():
	$StartButton.hide()
	$TittleBackground/Tittle.text = "Game over"
	$StartScreen.queue_free()


func _on_NewGame_pressed() -> void:
	get_tree().change_scene("res://scenes/Game.tscn")

func _on_Credits_pressed() -> void:
	get_tree().change_scene("res://scenes/Credits.tscn")
