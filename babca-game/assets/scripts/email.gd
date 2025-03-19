extends Area2D


@export var anim : AnimatedSprite2D
var scene_to_load = "uid://cwxqcyhjh0toh"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "babca" and sv.have_recept:
		
		anim.play()
		gl.allow_player_move = false
		await get_tree().create_timer(6.75).timeout
		anim.visible = false
		await get_tree().create_timer(1.0).timeout
		ms.start_music("silence")
		if scene_to_load:
			get_tree().change_scene_to_file(scene_to_load)
		
