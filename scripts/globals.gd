extends Node

var player_current_attack = false

var current_scene = "world" # world cliff_side
var transition_scene = false

var player_exit_cliff_side_posx = 223
var player_exit_cliff_side_posy = 25
var player_start_posx = 109
var player_start_posy = 129

var game_first_loading = true
func finish_changescene():
	print("Finish changescene, quitting", current_scene)
	print("Transition_scene", transition_scene)
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		elif current_scene == "cliff_side":
			current_scene = "world"
