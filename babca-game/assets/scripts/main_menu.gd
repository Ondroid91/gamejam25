extends CanvasLayer

@export var ani : AnimatedSprite2D
@export var quit_ani : AnimatedSprite2D
var scene_to_load = "uid://cea4qftgpxyvm"
@export var cursor_default : Texture2D
@export var cursor_touch : Texture2D
@export var cursor_drag : Texture2D
var save_file_path : String = "user://save_game.json"


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ms.start_music("menu")
	if cursor_default:
		Input.set_custom_mouse_cursor(cursor_default)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if cursor_drag:
				Input.set_custom_mouse_cursor(cursor_drag)
		else:
			if cursor_default:
				Input.set_custom_mouse_cursor(cursor_default)


func exist() -> void:
	ani.frame = 0

func click() -> void:
	ani.frame = 1
	delete_save()
	await get_tree().create_timer(0.5)
	sv.have_recept = false
	gl.allow_player_move = true
	ms.start_music("silence")
	get_tree().change_scene_to_file(scene_to_load)
	
func touch() -> void:
	ani.frame = 2

func quit() -> void:
	quit_ani.frame = 2
	await get_tree().create_timer(0.5)
	get_tree().quit()


func delete_save():
	if FileAccess.file_exists(save_file_path):
		var err = DirAccess.remove_absolute(save_file_path)
		if err == OK:
			print("Save file deleted successfully!")
		else:
			print("Failed to delete save file!")
	else:
		print("No save file found!")

func _on_button_pressed() -> void:
	click()

func _on_button_mouse_entered() -> void:
	touch()

func _on_button_mouse_exited() -> void:
	exist()

func _on_button_2_pressed() -> void:
	click()

func _on_button_2_mouse_entered() -> void:
	touch()

func _on_button_2_mouse_exited() -> void:
	exist()

func _on_button_3_pressed() -> void:
	quit()
