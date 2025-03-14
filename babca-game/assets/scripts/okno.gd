class_name okno
extends Node2D

# -------------- NODES ---------------------------
@export var ani_sprite_window : AnimatedSprite2D
@export var ani_sprite_in_window : AnimatedSprite2D
@export var ani_sprite_cancel_button : AnimatedSprite2D
@export var ani_sprite_min_button : AnimatedSprite2D
@export var animation_player : AnimationPlayer
@export var sound_player : AudioStreamPlayer2D
@export var static_coll : StaticBody2D
@export var cancel_button : Button
@export var min_button : Button
@export var move_button : Button

# ------------ WINDOW TYPE -----------------------
@export var window_type : String
@export var cancel_enabled : bool
@export var min_enabled : bool
@export var move_ver_enebled : bool = false
@export var move_hor_enebled : bool = false

# move button
var mouse_pos : Vector2
var window_moving : bool
var offset_x: float = 0
var offset_y: float = 0

# min button
@export var is_minimalized : bool = false


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
		if move_ver_enebled:
			self.position.y = mouse_pos.y - offset_y
		elif move_hor_enebled:
			self.position.x = mouse_pos.x - offset_x

func _on_cancel_button_pressed():
	queue_free()

func _on_min_button_pressed():
	if is_minimalized:
		is_minimalized = false
		static_coll.scale.y = 1
		static_coll.position.y = 0
	elif not is_minimalized:
		is_minimalized = true
		static_coll.scale.y = 0.2
		static_coll.position.y = -50


func _on_move_button_pressed():
	window_moving = true
	var mouse_pos = get_global_mouse_position()
	offset_x = mouse_pos.x - self.position.x
	offset_y = mouse_pos.y - self.position.y
	
func _on_move_button_released():
	window_moving = false
