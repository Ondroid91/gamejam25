class_name window
extends CharacterBody2D

# -------------- NODES ---------------------------
@export var ani_sprite_window: AnimatedSprite2D
@export var ani_sprite_in_window: AnimatedSprite2D
@export var ani_sprite_cancel_button: AnimatedSprite2D
@export var ani_sprite_min_button: AnimatedSprite2D
@export var animation_player: AnimationPlayer
@export var sound_player: AudioStreamPlayer2D
@export var static_coll: StaticBody2D
@export var cancel_button: Button
@export var min_button: Button
@export var move_button: Button

# ------------ WINDOW TYPE -----------------------
@export var window_type: String
@export var cancel_enabled: bool
@export var min_enabled: bool
@export var move_ver_enabled: bool = false
@export var move_hor_enabled: bool = false

@export var window_speed: float = 10.0  # Ovládání rychlosti pohybu
var window_moving: bool = false
var offset_x: float = 0
var offset_y: float = 0
var target_position: Vector2

func _ready():
	if cancel_button:
		cancel_button.pressed.connect(_on_cancel_button_pressed)
	if min_button:
		min_button.pressed.connect(_on_min_button_pressed)
	if move_button:
		move_button.button_down.connect(_on_move_button_pressed)
		move_button.button_up.connect(_on_move_button_released)

func _physics_process(delta: float) -> void:
	if window_moving:
		var mouse_pos = get_global_mouse_position()
		
		if move_hor_enabled:
			target_position.x = mouse_pos.x - offset_x
		if move_ver_enabled:
			target_position.y = mouse_pos.y - offset_y

	# Interpolace pohybu k cílové pozici s omezením kolizí
	velocity = (target_position - global_position) * window_speed * delta
	move_and_slide()

func _on_cancel_button_pressed():
	queue_free()

func _on_min_button_pressed():
	print("Minimize button pressed")

func _on_move_button_pressed():
	window_moving = true
	var mouse_pos = get_global_mouse_position()
	offset_x = mouse_pos.x - global_position.x
	offset_y = mouse_pos.y - global_position.y
	target_position = global_position  # Inicializace cílové pozice

func _on_move_button_released():
	window_moving = false
