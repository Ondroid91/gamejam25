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
@export var area_coll : Area2D
@export var max_coll : CollisionPolygon2D
@export var min_coll : CollisionShape2D
@export var cancel_button : Button
@export var min_button : Button
@export var move_button : Button

# ------------ WINDOW TYPE -----------------------
@export var window_type : String
@export var cancel_enabled : bool = true
@export var min_enabled : bool = true
@export var move_ver_enebled : bool = false
@export var move_hor_enebled : bool = false

# move button
var mouse_pos : Vector2
var window_moving : bool
var offset_x: float = 0
var offset_y: float = 0

# min button
@export var is_minimalized : bool = true


func _ready():
	if cancel_button:
		cancel_button.pressed.connect(_on_cancel_button_pressed)
	if min_button:
		min_button.pressed.connect(_on_min_button_pressed)
	if move_button:
		move_button.button_down.connect(_on_move_button_pressed)
		move_button.button_up.connect(_on_move_button_released)
	if area_coll:
		area_coll.body_entered.connect(_on_body_entered)

	update_buttons()

func _physics_process(delta: float) -> void:
	if window_moving:
		var mouse_pos = get_global_mouse_position()
		if move_ver_enebled:
			self.position.y = mouse_pos.y - offset_y
		elif move_hor_enebled:
			self.position.x = mouse_pos.x - offset_x



func update_buttons() -> void:
	if not cancel_enabled:
		button_animtion(ani_sprite_cancel_button, "default", 3)
	if is_minimalized:
		var anim = "maximaze"
		if min_enabled:
			button_animtion(ani_sprite_min_button, anim, 0)
		else:
			button_animtion(ani_sprite_min_button, anim, 3)
	else:
		var anim = "minimaze"
		if min_enabled:
			button_animtion(ani_sprite_min_button, anim, 0)
		else:
			button_animtion(ani_sprite_min_button, anim, 3)


func button_animtion(button : AnimatedSprite2D,anim : String, fram : int) -> void:
	button.animation = anim
	button.frame = fram


func loading_start() -> void:
	ani_sprite_window.play()
	await get_tree().create_timer(2.0).timeout
	queue_free()


func _on_body_entered(body):
	if body.name == "babca":
		loading_start()


func _on_cancel_button_pressed():
	if cancel_enabled:
		queue_free()

func _on_min_button_pressed():
	if min_enabled:
		if is_minimalized:
			is_minimalized = false
			min_coll.disabled = false
			max_coll.disabled = true
			ani_sprite_window.frame = 0
		elif not is_minimalized:
			is_minimalized = true
			min_coll.disabled = true
			max_coll.disabled = false
			ani_sprite_window.frame = 1
		update_buttons()

func _on_move_button_pressed():
	window_moving = true
	var mouse_pos = get_global_mouse_position()
	offset_x = mouse_pos.x - self.position.x
	offset_y = mouse_pos.y - self.position.y

func _on_move_button_released():
	window_moving = false
