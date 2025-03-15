extends Marker2D

@export var level : Node2D
@export var object_to_spawn : PackedScene
@export var delay : float = 0.0
@export var trigger : Area2D
@export var one_time : bool = true

func _ready():
	if trigger:
		trigger.triggered.connect(_on_trigger_activated)

func _on_trigger_activated():
	var object = object_to_spawn.instantiate()
	object.position = self.position
	await get_tree().create_timer(delay).timeout
	level.add_child(object)
	if one_time:
		queue_free()
