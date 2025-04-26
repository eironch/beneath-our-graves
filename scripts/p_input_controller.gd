extends Node

@export_category("Input Actions")
@export var action_right: String = "Right"
@export var action_left: String = "Left"
@export var action_attack: String = "Attack"
@export var action_careful: String = "Careful"

var cha: Player

func init(char_init: Player) -> void:
	cha = char_init

func process_input() -> void:
	# Handle inputs
	if Input.is_action_just_pressed(action_careful):
		cha.state.is_careful = not cha.state.is_careful
		cha.movement.update_speed(cha.state.is_careful)
	
	if Input.is_action_just_pressed(action_attack):
		cha.state.change_state("ATTACK")
		cha.state.is_careful = true

func get_input_direction() -> Vector2:
	var direction = Vector2.ZERO
	
	# Get horizontal movement
	if Input.is_action_pressed(action_right):
		direction.x = 1
	elif Input.is_action_pressed(action_left):
		direction.x = -1
	
	return direction
