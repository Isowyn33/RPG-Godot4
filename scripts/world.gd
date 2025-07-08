extends Node2D

func _ready():
	Global.current_scene = "world"
	if Global.game_first_loading == true:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
	else:
		$player.position.x = Global.player_exit_cliff_side_posx
		$player.position.y = Global.player_exit_cliff_side_posy
		$enemy.position.x = Global.slime_exit_cliff_side_posx
		$enemy.position.y = Global.slime_exit_cliff_side_posy

func _process(delta: float) -> void:
	change_scene()

func _on_cliff_side_transition_point_body_entered(body: Node2D) -> void:
	Global.slime_exit_cliff_side_posx = $enemy.position.x
	Global.slime_exit_cliff_side_posy = $enemy.position.y
	if body.has_method("player"):
		Global.transition_scene = true

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
			Global.game_first_loading = false
			Global.finish_changescene()
