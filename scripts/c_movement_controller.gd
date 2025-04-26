extends Node

@export_category("Movement Settings")
@export var normal_speed: float = 150
@export var careful_speed: float = 100
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
	
	var current_deceleration: float = (deceleration / 5 if speed == normal_speed else deceleration / 8) + get_process_delta_time()
	var current_acceleration: float = (acceleration / 10 if speed == normal_speed else acceleration / 16) + get_process_delta_time()
	
	if direction == Vector2.ZERO:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, current_deceleration)
	else:
		current_velocity = current_velocity.move_toward(target_velocity, current_acceleration)
	
	cha.velocity.x = current_velocity.x
func update_speed(is_careful: bool) -> void: 
	speed = careful_speed if is_careful else normal_speed
