extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_StartButton_pressed():
	$StartButton.hide()
	$TittleBackground/Tittle.text = "Game over"
	$StartScreen.queue_free()
