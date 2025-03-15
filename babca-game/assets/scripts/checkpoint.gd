extends Area2D

@export var save_icon : AnimatedSprite2D
var is_active : bool = false

func _ready():
	if save_icon:
		save_icon.frame = 0

func _process(delta: float) -> void:
	if sv.current_checkpoint != self.position:
		is_active = false
		if save_icon:
			save_icon.frame = 0
	else:
		is_active = true
		if save_icon:
			save_icon.frame = 2
	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "babca" and save_icon:
		
		sv.current_checkpoint = self.position
		if not is_active:
			is_active = true
			save_icon.frame = 2
		else:
			save_icon.frame = 2
