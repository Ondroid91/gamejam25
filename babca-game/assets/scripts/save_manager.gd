extends Node

# Exportované proměnné pro cestu k souboru
@export var save_file_path : String = "user://save_game.json"  # Cesta pro uložený soubor

# Údaje o hře, které chceme uložit
var current_checkpoint : Vector2 = Vector2(0, 0)


# Načtení uložených dat
func load_game():
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		if file:
				var json_data = file.get_as_text()
				var json = JSON.new()  # Vytvoříme instanci JSON třídy
				var save_data = json.parse(json_data)  # Použijeme metodu parse() na instanci
				file.close()

				if save_data == OK:
						current_checkpoint = json.get_data()["current_checkpoint"]
						print("Game loaded!")
				else:
						print("Error loading game data.")
		else:
				print("No save file found.")

# Uložení dat
func save_game():
		var save_data = {
				"current_checkpoint": current_checkpoint
		}
		var json = JSON.new()  # Vytvoříme instanci JSON třídy
		var json_data = json.print(save_data)  # Použijeme metodu print() na instanci

		var file = FileAccess.open(save_file_path, FileAccess.WRITE)
		if file:
				file.store_string(json_data)
				file.close()
				print("Game saved!")
		else:
				print("Failed to save game!")
