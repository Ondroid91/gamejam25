extends CharacterBody2D


@export var trigger : Area2D
@export var anim : AnimationPlayer
var alive = true
var allow_gravity = false

func _ready():
	if trigger and trigger.kill:
		trigger.triggered.connect(_on_trigger_activated)
	
	await get_tree().create_timer(1.0).timeout
	allow_gravity = true

func _physics_process(delta: float) -> void:
	if allow_gravity:
		velocity.y += self.get_gravity().y * delta  
		move_and_slide()
	if velocity.y > 0 and alive:
		anim.play("fall")
	elif velocity.y == 0 and alive:
		anim.play("idle")
	else:
		anim.play("death")

func _on_trigger_activated():
	alive = false
