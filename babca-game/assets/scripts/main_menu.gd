extends CanvasLayer

@export var ani : AnimatedSprite2D
@export var quit_ani : AnimatedSprite2D
var scene_to_load = "uid://cea4qftgpxyvm"

func _ready() -> void:
	ms.start_music("menu")

func exist() -> void:
	ani.frame = 0

func click() -> void:
	ani.frame = 1
	await get_tree().create_timer(0.5)
	get_tree().change_scene_to_file(scene_to_load)
	
func touch() -> void:
	ani.frame = 2

func quit() -> void:
	quit_ani.frame = 2
	await get_tree().create_timer(0.5)
	get_tree().quit()

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
