extends Node

@export var music_player : AudioStreamPlayer2D
@export var menu_oundtrack : AudioStream
@export var main_soundtrack : AudioStream


func _ready():
	music_player.play()

func start_music(where_am_i : String) -> void:  # game, menu
	var music : AudioStream
	if where_am_i == "game":
		music = main_soundtrack
	elif where_am_i == "menu":
		music = menu_oundtrack
	music_player.stream = music
	music_player.play()
