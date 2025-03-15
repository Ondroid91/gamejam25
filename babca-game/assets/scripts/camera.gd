extends CharacterBody2D

@export var target: CharacterBody2D
@export var follow_speed: float = 5.0
@export var offset: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if target:
		global_position = global_position.lerp(target.global_position + offset, follow_speed * delta)
