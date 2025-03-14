extends CharacterBody2D


@export var target: CharacterBody2D
@export var follow_speed: float = 5.0  # Rychlost sledování
@export var offset: Vector2 = Vector2.ZERO  # Posunutí kamery oproti hráči

func _physics_process(delta: float) -> void:
	if target:
		# Interpolace mezi současnou a cílovou pozicí (plynulý pohyb)
		global_position = global_position.lerp(target.global_position + offset, follow_speed * delta)
