extends Camera2D

@export var target: CharacterBody2D

const follow_speed: int = 50

func _process(delta: float) -> void:
	if !target:
		return
	
	var target_loc: Vector2 = Vector2(target.position.x, target.position.y - 150)
	
	position = lerp(position, target_loc, delta * follow_speed)
