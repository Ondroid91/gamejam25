extends Control

@export var refresh_icon : AnimatedSprite2D


func _on_start_pressed() -> void:
	pass


func _on_refresh_pressed() -> void:
	refresh_icon.frame = 2
	await get_tree().create_timer(0.2).timeout
	refresh_icon.frame = 0
	await get_tree().create_timer(0.1).timeout
	get_tree().reload_current_scene()
