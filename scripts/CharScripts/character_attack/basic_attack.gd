extends Node2D

@onready var player: Player = get_owner()
@onready var attack_handler: AttackHandler = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player.is_attacking):
		return
	
	if Input.is_action_just_pressed("cast_attack"):
		var attack_direction = (get_global_mouse_position() - player.global_position).normalized()
		var attack_duration = 1 / player.ATTACK_SPEED
		attack_handler.execute_attack(attack_duration, attack_direction)
