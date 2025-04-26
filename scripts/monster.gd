class_name Monster extends CharacterBody2D

@export_category("References")
@export var sprite_path: NodePath
@export var state_path: NodePath
@export var movement_path: NodePath
@export var input_path: NodePath

var sprite: AnimatedSprite2D
var state: Node
var movement: Node
var input: Node

func _ready() -> void:
	# Get nodes
	sprite = get_node_or_null(sprite_path)
	state = get_node_or_null(state_path)
	movement = get_node_or_null(movement_path)
	input = get_node_or_null(input_path)
	
	if state:
		state.init(self)
	if movement:
		movement.init(self)
	if input:
		input.init(self)
	
	# Connect signals
	if state:
		state.state_changed.connect(_on_state_changed)
	if sprite:
		sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	# Handle gravity
	if not is_on_floor():
		velocity.y += 98 * delta
		pass
	else:
		velocity.y = 0
	
	# Call StateMachine process
	state.process()
	
	move_and_slide()

func _on_state_changed(new_state: String) -> void:
	sprite.play(new_state.to_lower())
	
	if new_state != "SWITCH":
		_update_sprite_direction()

func _update_sprite_direction() -> void:
	match state.current_facing:
		Vector2.RIGHT:
			sprite.flip_h = false
		Vector2.LEFT:
			sprite.flip_h = true

func _on_animation_finished() -> void:
	state.handle_animation_finished()
