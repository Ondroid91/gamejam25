extends Node


var alive : bool
var spawn_friend = false
var allow_player_move = true

func _ready() -> void:
	alive = true


func send_signal() -> void:
	emit_signal("triggered", )
