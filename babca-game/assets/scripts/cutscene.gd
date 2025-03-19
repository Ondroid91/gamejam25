class_name cutscene
extends Control

@export var cut_scene: VideoStreamPlayer
@export var type_of_cutscene: String
@export var next_scene: PackedScene

var opening_cut_scene = preload("res://assets/cut_scenes/babcha-cutscene_johi_2.ogv")
var ending_cut_scene = preload("res://assets/cut_scenes/ending.ogv")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if cut_scene:
		match type_of_cutscene:
			"opening":
				cut_scene.stream = opening_cut_scene
			"ending":
				cut_scene.stream = ending_cut_scene

		cut_scene.play()
		cut_scene.finished.connect(_on_video_finished)

func _on_video_finished() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
