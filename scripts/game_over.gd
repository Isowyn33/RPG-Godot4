extends CanvasLayer



func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	


func _on_quit_button_pressed() -> void:
	get_tree().quit()
