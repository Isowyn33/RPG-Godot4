extends Control

func _ready() -> void:
	var attack_key = Global.get_key_for_action("attack")
	$CenterContainer/VBoxContainer/attack_label.text = "Press [" +attack_key+"] to attack"
func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
