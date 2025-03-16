extends CanvasLayer

@export var refresh_icon : AnimatedSprite2D
@export var recept : Sprite2D
@export var death_screen : Sprite2D

func _process(delta: float) -> void:
	if not gl.alive:
		death()
		gl.alive = true
	if sv.have_recept:
		print("sdkjdfls")
		recept.visible = true


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("refresh"):
		get_tree().paused = false
		death_screen.visible = false
		

func _on_start_pressed() -> void:
	pass

func death() -> void:
	ms.start_music("death")
	death_screen.visible = true
	get_tree().paused = true

func _on_refresh_pressed() -> void:
	sv.load_game()
	refresh_icon.frame = 2
	await get_tree().create_timer(0.2).timeout
	refresh_icon.frame = 0
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	death_screen.visible = false
	gl.alive = true
	get_tree().reload_current_scene()

func _on_sound_pressed() -> void:
	if AudioServer.is_bus_mute(0):
		AudioServer.set_bus_mute(0, false)
	else:
		AudioServer.set_bus_mute(0, true)
