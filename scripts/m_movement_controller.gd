extends Node

@export_category("Movement Settings")
@export var normal_speed: float = 100
@export var careful_speed: float = 50
@export var acceleration: float = 10.0
@export var deceleration: float = 15.0

# Current speed
var speed: float = 0
var target_velocity: Vector2 = Vector2.ZERO
var current_velocity: Vector2 = Vector2.ZERO

var cha: CharacterBody2D

func init(char_init: CharacterBody2D) -> void:
	cha = char_init
	speed = normal_speed
	
func move(direction: Vector2) -> void:
	target_velocity = direction * speed
	
	if direction == Vector2.ZERO:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, deceleration + get_process_delta_time())
	else:
		current_velocity = current_velocity.move_toward(target_velocity, acceleration + get_process_delta_time())
		
	cha.velocity.x = current_velocity.x
	
func update_speed(is_careful: bool) -> void:
	speed = careful_speed if is_careful else normal_speed
