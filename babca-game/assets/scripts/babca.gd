class_name Player
extends CharacterBody2D

# PLAYER COMPONENTS----------------------------------------------- #
@export var body_collision : CollisionShape2D
@export var sprite : Sprite2D
@export var ground_ray : RayCast2D
# ---------------------------------------------------------------- #

# PLAYER STATS---------------------------------------------------- #
@export var jump_speed : int
@export var speed : int
@export var acceleration: float = 10.0
@export var friction: float = 5.0
# ----------------------------------------------------------------- #

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
	print(ground_ray.is_colliding())

func player_movement(delta: float) -> void:
	velocity.y += self.get_gravity().y * delta  
	var input_direction = Input.get_axis("left", "right")
	if input_direction != 0:
		velocity.x = lerp(velocity.x, input_direction * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
	if Input.is_action_pressed("up") and ground_ray.is_colliding():
		print("jump")
		velocity.y -= jump_speed
	move_and_slide()
