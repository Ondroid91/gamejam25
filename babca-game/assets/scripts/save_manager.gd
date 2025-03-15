extends Node

@export var save_file_path : String = "user://save_game.json"

var current_checkpoint : Vector2 = Vector2(0, 0)
var have_recept : bool = false

func load_game():
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		if file:
				var json_data = file.get_as_text()
				var json = JSON.new()
				var save_data = json.parse(json_data)
				file.close()

				if save_data == OK:
						current_checkpoint = json.get_data()["current_checkpoint"]
						have_recept = json.get_data()["have_recept"]
						print("Game loaded!")
				else:
						print("Error loading game data.")
		else:
				print("No save file found.")

func save_game():
		var save_data = {
				"current_checkpoint": current_checkpoint,
				"have_recept": have_recept
		}
		var json = JSON.new()
		var json_data = json.print(save_data)

		var file = FileAccess.open(save_file_path, FileAccess.WRITE)
		if file:
				file.store_string(json_data)
				file.close()
				print("Game saved!")
		else:
				print("Failed to save game!")
