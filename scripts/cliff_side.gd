extends Node2D

func _ready():
	Global.current_scene = "cliff_side"

func _process(delta: float) -> void:
	change_scene()

func _on_cliff_side_exit_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true
		Global.current_scene = "cliff_side"

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "cliff_side":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescene()
