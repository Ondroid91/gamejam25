extends Node

@onready var music_player = $AudioStreamPlayer

func _ready():
	if not music_player.playing:
		music_player.play()
