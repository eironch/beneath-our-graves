extends Node

@export var debug: bool = false

signal state_changed(new_state)

enum State {
	IDLE, WALK, ATTACK, SWITCH
}

var current_state: State
var current_facing: Vector2 = Vector2.RIGHT
var cha: CharacterBody2D
var is_careful: bool = false

func init(char_init: CharacterBody2D) -> void:
	cha = char_init
	
	# Initialize state
	change_state("IDLE")

func process() -> void:
	match current_state:
		State.IDLE, State.WALK:
			_process_action_state()
		State.ATTACK:
			cha.velocity.x = 0
	
func _process_action_state() -> void:
	var direction = cha.input.get_input_direction()
	var previous_facing = current_facing
	
	# Handle facing direction
	if direction.x > 0:
		current_facing = Vector2.RIGHT
	elif direction.x < 0:
		current_facing = Vector2.LEFT
	
	if current_facing != previous_facing:
		change_state("SWITCH")
	
	cha.movement.move(direction)
	
	if current_state == State.SWITCH:
		return
	
	cha.input.process_input()
	
	# Handle state
	if current_state == State.ATTACK:
		return
	
	if direction == Vector2.ZERO:
		change_state("IDLE" if not is_careful else "CAREFUL_IDLE")
	else:
		change_state("WALK" if not is_careful else "CAREFUL_WALK")

func change_state(new_state: String) -> void:
	if is_in_state(new_state):
		return
	
	current_state = State[new_state]
	
	if debug:
		print("State changed to ", new_state)
	
	emit_signal("state_changed", new_state)
	
func handle_animation_finished() -> void:
	match current_state:
		State.ATTACK:
			change_state("CAREFUL_IDLE")
		State.SWITCH:
			change_state("IDLE" if cha.input.get_input_direction() == Vector2.ZERO else "WALK")

# Helper functions
func get_current_state_name() -> String:
	return State.keys()[current_state]
	
func is_in_state(state: String) -> bool:
	return state == get_current_state_name()
