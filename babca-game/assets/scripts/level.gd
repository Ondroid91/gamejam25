extends Node2D


@export var player : PackedScene
@export var camera : PackedScene


func _ready() -> void:
	if player and camera:
		#spawn_player()
		pass

func _process(delta: float) -> void:
	if not gl.alive:
		death()
		gl.alive = true

func death() -> void:
	print("you died")

func spawn_player() -> void:
	var babca = player.instantiate()
	babca.position = sv.current_checkpoint
	add_child(babca)
	var cam = camera.instantiate()
	cam.position = sv.current_checkpoint
	cam.target = babca
	add_child(cam)
