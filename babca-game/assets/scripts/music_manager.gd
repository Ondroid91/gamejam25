extends AudioStreamPlayer

@export var menu_oundtrack : AudioStream
@export var main_soundtrack : AudioStream
@export var death_screen : AudioStream
var empty : AudioStream

func start_music(where_am_i : String) -> void:
	var music : AudioStream
	if where_am_i == "game":
		music = main_soundtrack
	elif where_am_i == "menu":
		music = menu_oundtrack
	elif where_am_i == "death":
		music = death_screen
	elif where_am_i == "silence":
		music = empty
	stream = music
	play()
