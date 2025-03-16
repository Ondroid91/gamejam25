extends Area2D

@export var collect_sound : AudioStreamPlayer2D
@export var image : AnimatedSprite2D

func _ready() -> void:
	image.play()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "babca":
		sv.have_recept = true
		collect_sound.play()
		image.visible = false
		await get_tree().create_timer(2.0).timeout
		queue_free()
