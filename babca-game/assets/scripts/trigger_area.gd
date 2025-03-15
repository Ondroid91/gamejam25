extends Area2D

signal triggered

@export var kill : bool = false
@export var spawn : bool
@export var was_pressed = false

func _ready():
	add_to_group("triggers")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "babca" and kill:
		gl.alive = false
	if body.name == "babca" and spawn:
		emit_signal("triggered")
