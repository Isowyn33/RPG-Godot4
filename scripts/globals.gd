extends Node
var player_name = ""
var player_current_attack = false
var ennemies_killed = {}
var current_scene = "world" # world cliff_side
var transition_scene = false

var player_exit_cliff_side_posx = 223
var player_exit_cliff_side_posy = 25
var slime_exit_cliff_side_posx = 0
var slime_exit_cliff_side_posy = 0
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

func get_key_for_action(action_name: String) -> String:
	var events = InputMap.action_get_events(action_name)
	for event in events:
		if event is InputEventKey:
			var physical_keycode = event.physical_keycode
			if physical_keycode != 0:
				return OS.get_keycode_string(physical_keycode)
			elif event.keycode != 0:
				return OS.get_keycode_string(event.keycode)
	return "Unbound"
