extends Node

var alive : bool

var spawn_friend = false

func _ready() -> void:
	alive = true
	AudioServer.set_bus_mute(0, true)




func send_signal() -> void:
	emit_signal("triggered", )
