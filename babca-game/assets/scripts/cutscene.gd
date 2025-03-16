extends Control

@export var cut_scene : VideoStreamPlayer
@export var type_of_cutscene : String

var opening_cut_scene
var ending_cut_scene

func _ready():
	if cut_scene:
		cut_scene.play()
		cut_scene.finished.connect(_on_video_finished)
	

func _on_video_finished() -> void:
	match type_of_cutscene:
		"opening":
			get_tree().change_scene_to_file(opening_cut_scene)
		"ending":
			get_tree().change_scene_to_file(ending_cut_scene)
