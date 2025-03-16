extends Node

@export var save_file_path : String = "user://save_game.json"

var current_checkpoint : Vector2 = Vector2(0, 0)
var have_recept : bool = false

func load_game():
		if not FileAccess.file_exists(save_file_path):
				print("No save file found.")
				return

		var file = FileAccess.open(save_file_path, FileAccess.READ)
		if not file:
				print("Error opening save file.")
				return

		var json_data = file.get_as_text()
		file.close()

		var json = JSON.new()
		var parse_result = json.parse(json_data)

		if parse_result != OK:
				print("Error parsing save file.")
				return

		var save_data = json.data

		if "current_checkpoint" in save_data:
				current_checkpoint = Vector2(save_data["current_checkpoint"][0], save_data["current_checkpoint"][1])
		if "have_recept" in save_data:
				have_recept = save_data["have_recept"]

		print("Game loaded!")

func save_game():
		var save_data = {
				"current_checkpoint": [current_checkpoint.x, current_checkpoint.y],
				"have_recept": have_recept
		}
		var json_string = JSON.stringify(save_data)
		var file = FileAccess.open(save_file_path, FileAccess.WRITE)
		if not file:
				print("Failed to save game!")
				return

		file.store_string(json_string)
		file.close()
		print("Game saved!")
