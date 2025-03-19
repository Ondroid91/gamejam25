extends Area2D

@export var collect_sound : AudioStreamPlayer2D
@export var image : AnimatedSprite2D

func _ready() -> void:
	image.play()
	
	if sv.have_recept:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "babca":
		collect_sound.play()
		image.visible = false
		sv.have_recept = true
		await get_tree().create_timer(2.0).timeout
		image.visible = false
		sv.have_recept = true
		queue_free()
