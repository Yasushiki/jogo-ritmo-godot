extends TextureRect

var score = Global.score

func _on_Timer_timeout() -> void:
	get_node(".").rect_position = Vector2(0, -1080)
	
	$Label.text = "SCORE: " + str(score)

func _on_ButtonMenu_pressed() -> void:
	get_tree().change_scene("res://scenes/Main.tscn")
