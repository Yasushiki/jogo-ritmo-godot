extends CanvasLayer

func _on_StartButton_pressed():
	$StartButton.hide()
	$TittleBackground/Tittle.text = "Game over"
	$StartScreen.queue_free()
