extends CanvasLayer


func _on_start_button_pressed() -> void:
	if $CenterContainer/VBoxContainer/player_name_textedit.text != "":
		Global.player_name = $CenterContainer/VBoxContainer/player_name_textedit.text
	else:
		Global.player_name = "Player"
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")



func _on_quit_button_pressed() -> void:
	get_tree().quit()
