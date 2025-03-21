class_name okno
extends Node2D

# -------------- NODES ---------------------------
@export var ani_sprite_window : AnimatedSprite2D
@export var ani_sprite_in_window : AnimatedSprite2D
@export var ani_sprite_cancel_button : AnimatedSprite2D
@export var ani_sprite_min_button : AnimatedSprite2D
@export var ani_sprite_move_button : AnimatedSprite2D
@export var sound_player : AudioStreamPlayer2D
@export var static_coll : StaticBody2D
@export var area_coll : Area2D
@export var max_coll : CollisionPolygon2D
@export var min_coll : CollisionShape2D
# buttons
@export var cancel_button : Button
@export var min_button : Button
@export var move_button : Button
@export var yes_button : Button
@export var no_button : Button

@export var one_up : Button
@export var one_down : Button
@export var two_up : Button
@export var two_down : Button
@export var three_up : Button
@export var three_down : Button

@export var first_num : Label
@export var second_num : Label
@export var third_num : Label
@export var code_print : Label
# ------------ WINDOW TYPE -----------------------
@export var window_type : String
@export var window_image : int = 0
@export var cancel_enabled : bool = true
@export var min_enabled : bool = true
@export var move_ver_enebled : bool = false
@export var move_hor_enebled : bool = false
@export var virus : bool = false
@export var is_minimalized : bool = true


# move button
var mouse_pos : Vector2
var window_moving : bool
var offset_x: float = 0
var offset_y: float = 0


# code panel
var numbers1 : Array = [3, 0, 8, 2, 7, 6, 9, 5, 1, 4]
var numbers2 : Array = [5, 9, 7, 3, 1, 4, 0, 8, 6, 2]
var numbers3 : Array = [1, 9, 4, 8, 3, 2, 7, 0, 6, 5]
var label1 : int = numbers1[0]
var label2 : int = numbers1[0]
var label3 : int = numbers1[0]
var num_pos1 : int = numbers1[1]
var num_pos2 : int = numbers1[6]
var num_pos3 : int = numbers1[7]
var code : = "295"

#windows
@export var max_dis : float = 500
var origin_pos : Vector2

func _ready():
	if cancel_button:
		cancel_button.pressed.connect(_on_cancel_button_pressed)
	if min_button:
		min_button.pressed.connect(_on_min_button_pressed)
	if move_button:
		move_button.button_down.connect(_on_move_button_pressed)
		move_button.button_up.connect(_on_move_button_released)
	if yes_button:
		yes_button.pressed.connect(_on_yes_button_pressed)
	if no_button:
		no_button.pressed.connect(_on_no_button_pressed)
	if one_up:
		one_up.pressed.connect(_on_one_up_pressed)
	if one_down:
		one_down.pressed.connect(_on_one_down_pressed)
	if two_up:
		two_up.pressed.connect(_on_two_up_pressed)
	if two_down:
		two_down.pressed.connect(_on_two_down_pressed)
	if three_up:
		three_up.pressed.connect(_on_three_up_pressed)
	if three_down:
		three_down.pressed.connect(_on_three_down_pressed)
	
	if area_coll:
		area_coll.body_entered.connect(_on_body_entered)
	
	update_win_image()
	if not area_coll and not yes_button and  not no_button:
		ani_sprite_window.frame = 1
	if not is_minimalized and not virus:
		_on_min_button_pressed()
	else:
		_on_min_button_pressed()
	
	update_buttons()
	origin_pos = position
	
	
func update_win_image() -> void:
	# window image
	match window_image:
		0:
			ani_sprite_window.animation = "default"
		1:
			ani_sprite_window.animation = "new_animation"
		2:
			ani_sprite_window.animation = "new_animation_1"
		3:
			ani_sprite_window.animation = "new_animation_2"
		4:
			ani_sprite_window.animation = "new_animation_3"
		5:
			ani_sprite_window.animation = "new_animation_4"
		6:
			ani_sprite_window.animation = "new_animation_5"
		7:
			ani_sprite_window.animation = "new_animation_5"

func _physics_process(delta: float) -> void:
	if window_moving:
		var mouse_pos = get_global_mouse_position()
		if (mouse_pos - origin_pos).length() < max_dis:
			if move_ver_enebled:
				self.position.y = mouse_pos.y - offset_y
			elif move_hor_enebled:
				self.position.x = mouse_pos.x - offset_x


func update_buttons() -> void:
	if not cancel_enabled:
		button_animtion(ani_sprite_cancel_button, "default", 3)
	if is_minimalized:
		var anim = "minimaze"
		if min_enabled:
			button_animtion(ani_sprite_min_button, anim, 0)
		else:
			button_animtion(ani_sprite_min_button, anim, 3)
	else:
		var anim = "maximaze"
		if min_enabled:
			button_animtion(ani_sprite_min_button, anim, 0)
		else:
			button_animtion(ani_sprite_min_button, anim, 3)
	if ani_sprite_move_button:
		if not move_ver_enebled and not move_hor_enebled:
			ani_sprite_move_button.visible = false
		elif move_ver_enebled:
			ani_sprite_move_button.frame = 1
		elif move_hor_enebled:
			ani_sprite_move_button.frame = 0


func button_animtion(button : AnimatedSprite2D,anim : String, fram : int) -> void:
	button.animation = anim
	button.frame = fram

func loading_start() -> void:
	ani_sprite_window.play()
	await get_tree().create_timer(2.0).timeout
	queue_free()

func answer_friend_request(accepted : bool) -> void:
	if accepted:
		gl.spawn_friend = true
		queue_free()
	else:
		queue_free()

var cookies_stage : int = 0
func cookies(answer : bool, stage : int) -> void:
	print("cookies")
	var get_cookied = false
	match stage:
		0:
			if answer:
				get_cookied = true
			cookies_stage += 1
			window_image += 1
		1:
			if not answer:
				get_cookied = true
			cookies_stage += 1
			window_image += 1
		2:
			if answer:
				get_cookied = true
			cookies_stage += 1
			window_image += 1
			yes_button.text = "JA"
			no_button.text = "NEIN"
		3:
			if answer:
				get_cookied = true
			cookies_stage += 1
			window_image += 1
			yes_button.text = "SEY"
			no_button.text = "ON"
		4:
			if answer: #nemecky
				get_cookied = true
			cookies_stage += 1
			window_image += 1
			yes_button.text = "YES"
			no_button.text = "NO"
		5:
			if answer:
				get_cookied = true
			else:
				queue_free()

			cookies_stage += 1
			window_image += 1
	update_win_image()
	if get_cookied:
		ani_sprite_window.frame = 1
		await get_tree().create_timer(2.0).timeout
		gl.alive = false


# ----------- TRIGGERS ----------------------------

func _on_body_entered(body):
	if body.name == "babca":
		loading_start()

func _on_yes_button_pressed():
	if window_type == "code window":
		var my_code = first_num.text + second_num.text + third_num.text
		if code == my_code:
			queue_free()
		else:
			yes_button.disabled = true
			code_print.text = "Incorrect code!"
			await get_tree().create_timer(0.5).timeout
			code_print.text = ""
			await get_tree().create_timer(0.5).timeout
			code_print.text = "Incorrect code!"
			await get_tree().create_timer(0.5).timeout
			code_print.text = ""
			await get_tree().create_timer(0.5).timeout
			code_print.text = "Incorrect code!"
			await get_tree().create_timer(0.5).timeout
			yes_button.disabled = false
	elif window_type == "cookies":
		cookies(true, cookies_stage)
	else:
		answer_friend_request(true)

func _on_no_button_pressed():
	if window_type == "cookies":
		cookies(false, cookies_stage)
	else:
		answer_friend_request(false)

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
			if virus:
				min_enabled = false
				update_buttons()
				await get_tree().create_timer(1.0).timeout
				gl.alive = false
		update_buttons()

func _on_move_button_pressed():
	window_moving = true
	var mouse_pos = get_global_mouse_position()
	offset_x = mouse_pos.x - self.position.x
	offset_y = mouse_pos.y - self.position.y

func _on_move_button_released():
	window_moving = false

# code panel
func update_numbers(label : Label, label_num : int) -> void:
	var text : int
	match label_num:
		1:
			label1 = numbers1[num_pos1]
			text = label1
		2:
			label2 = numbers2[num_pos2]
			text = label2
		3:
			label3 = numbers3[num_pos3]
			text = label3
	label.text = str(text)

func _on_one_up_pressed():
	if num_pos1 == 9:
		num_pos1 = 0
	else:
		num_pos1 += 1
	update_numbers(first_num, 1)

func _on_one_down_pressed():
	if num_pos1 == 0:
		num_pos1 = 9
	else:
		num_pos1 -= 1
	update_numbers(first_num, 1)

func _on_two_up_pressed():
	if num_pos2 == 9:
		num_pos2 = 0
	else:
		num_pos2 += 1
	update_numbers(second_num, 2)

func _on_two_down_pressed():
	if num_pos2 == 0:
		num_pos2 = 9
	else:
		num_pos2 -= 1
	update_numbers(second_num, 2)

func _on_three_up_pressed():
	if num_pos3 == 9:
		num_pos3 = 0
	else:
		num_pos3 += 1
	update_numbers(third_num, 3)

func _on_three_down_pressed():
	if num_pos3 == 0:
		num_pos3 = 9
	else:
		num_pos3 -= 1
	update_numbers(third_num, 3)
