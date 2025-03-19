class_name Player
extends CharacterBody2D

# PLAYER COMPONENTS----------------------------------------------- #
@export var body_collision : CollisionShape2D
@export var player_sprite : AnimatedSprite2D
@export var player_sounds : AudioStreamPlayer2D
@export var ground_ray : RayCast2D

# ---------------------------------------------------------------- #

# PLAYER STATS---------------------------------------------------- #
@export var jump_speed : int
@export var speed : int
@export var acceleration: float = 10.0
@export var friction: float = 5.0
# ----------------------------------------------------------------- #



<<<<<<< HEAD

=======
>>>>>>> cb76baec5ae82b01787911cd20895d03daa3a68c
func _physics_process(delta: float) -> void:
	if gl.allow_player_move:
		player_movement(delta)
	refresh()
	velocity.y += self.get_gravity().y * delta 

func player_movement(delta: float) -> void:
	#movement 
	var input_direction = Input.get_axis("left", "right")
	if input_direction != 0:
		velocity.x = lerp(velocity.x, input_direction * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
	if Input.is_action_pressed("up") and ground_ray.is_colliding():
		velocity.y -= jump_speed
	if velocity.y < -jump_speed:
		velocity.y = 1000
	
	move_and_slide()
	# animations
	if ground_ray.is_colliding():
		match input_direction:
			-1.0:
				play_animation("walk", false)
			1.0:
				play_animation("walk", true)
			0.0:
				play_animation("idle")
	else:
		match input_direction:
			-1.0:
				if velocity.y < 0:
					play_animation("jump", false)
				elif velocity.y > 0:
					play_animation("fall", false)
			1.0:
				if velocity.y < 0:
					play_animation("jump", true)
				elif velocity.y > 0:
					play_animation("fall", true)

	
func refresh() -> void:
	if Input.is_action_just_pressed("refresh"):
		sv.load_game()
		
		get_tree().reload_current_scene()

func play_animation(anim : String, flip : bool = player_sprite.flip_h) -> void:
	player_sprite.flip_h = flip
	player_sprite.play(anim)
	
	
	
	
