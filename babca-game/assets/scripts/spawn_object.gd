extends Marker2D

@export var level : Node2D
@export var object_to_spawn : PackedScene
@export var delay : float = 0.0
@export var trigger : Area2D
@export var one_time : bool = true
@export var friend : bool = false
func _ready() -> void:
	if trigger:
		trigger.triggered.connect(_on_trigger_activated)

func _process(delta: float) -> void:
	if gl.spawn_friend and friend:
		_on_trigger_activated()
		gl.spawn_friend = false

func _on_trigger_activated() -> void:
	var object = object_to_spawn.instantiate()
	object.position = self.position
	if friend:
		object.trigger = trigger
	await get_tree().create_timer(delay).timeout
	level.add_child(object)
	if one_time:
		queue_free()
