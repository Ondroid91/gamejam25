extends Node

var alive : bool

func _ready() -> void:
	alive = true

func send_signal() -> void:
	emit_signal("triggered", )
