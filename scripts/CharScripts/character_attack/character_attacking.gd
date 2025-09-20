class_name AttackHandler
extends Node2D

@onready var player: Player = get_owner()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func execute_attack(duration: float, direction: Vector2 = Vector2.ZERO) -> void:
	player.is_moving = false
	player.is_attacking = true
	
	if direction != Vector2.ZERO:
		player.face_direction = direction
	
	var t = get_tree().create_timer(duration)
	t.timeout.connect(func():
		player.is_attacking = false
	)
