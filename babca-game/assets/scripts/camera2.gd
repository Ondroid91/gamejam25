extends Camera2D

@export var target : Node2D
@export var follow_speed : float = 5.0
@export var off_set : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if target:
		var target_position = target.position + off_set
		position = position.lerp(target_position, follow_speed * delta)
