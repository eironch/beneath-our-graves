extends Node

var cha: Monster

func init(char_init: Monster) -> void:
	cha = char_init

func process_input() -> void:
	pass
	# Handle inputs
	#if Input.is_action_just_pressed(action_careful):
		#cha.state.is_careful = not cha.state.is_careful
		#cha.movement.update_speed(cha.state.is_careful)
	#
	#if Input.is_action_just_pressed(action_attack):
		#cha.state.change_state("ATTACK")
		#cha.state.is_careful = true

func get_input_direction() -> Vector2:
	var direction = Vector2.ZERO
	var nearest = get_nearest_character(cha.global_position)
	
	if nearest == null:
		return direction
	
	if nearest.global_position.x > cha.global_position.x:
		direction.x = 1
	else:
		direction.x = -1
	
	return direction

# Helper functions
func get_nearest_character(from_position: Vector2) -> CharacterBody2D:
	var character_nodes = get_tree().get_nodes_in_group("character")
	
	var nearest_character: CharacterBody2D = null
	var min_distance: float = INF
	
	for character: CharacterBody2D in character_nodes:
		var distance = from_position.distance_to(character.global_position)
		
		if distance < min_distance:
			min_distance = distance
			nearest_character = character
	
	return nearest_character
